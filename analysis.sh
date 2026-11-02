
#!/bin/bash

# Luodaan analyysiraportti
{
    echo "GitHub-repositorion analyysiraportti"
    echo "=================================="
    echo ""

    echo "1. Tunnistetut kielet ja tiedostotyypit:"

    for ext in html css js ts py java; do
        if git ls-files "*.$ext" | grep -q .; then
            echo "- .$ext"
        fi
    done

    echo ""
    echo "2. Mahdolliset suunnittelumallit:"

    found=false

    if git grep -Eiq 'getInstance|class[[:space:]]+Singleton' -- '*.js' '*.ts' '*.py' '*.java'; then
        echo "- Singleton"
        found=true
    fi

    if git grep -Eiq 'Factory|create[A-Z]' -- '*.js' '*.ts' '*.py' '*.java'; then
        echo "- Factory Method"
        found=true
    fi

    if git grep -Eiq 'addObserver|notifyObservers|subscribe' -- '*.js' '*.ts' '*.py' '*.java'; then
        echo "- Observer"
        found=true
    fi

    if git grep -Eiq 'Decorator|@decorator' -- '*.js' '*.ts' '*.py' '*.java'; then
        echo "- Decorator"
        found=true
    fi

    if git grep -Eiq 'Strategy|setStrategy' -- '*.js' '*.ts' '*.py' '*.java'; then
        echo "- Strategy"
        found=true
    fi

    if [ "$found" = false ]; then
        echo "- Suunnittelumalleihin viittaavia merkkeja ei loytynyt."
    fi

} > analysis_report.txt

echo "Analyysi valmis!"

cat analysis_report.txt
