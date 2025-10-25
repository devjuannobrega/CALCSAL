pipeline {
    agent any
    
    environment {
        API_URL = 'http://localhost:8000'
        JOB_ID = '9fd35aec-8c73-4610-8a65-b5ed2a335e77'
    }
    
    stages {
        stage('1. Validacao') {
            steps {
                echo "Validando ambiente..."
                
                bat '''
                    echo Repositorio clonado:
                    git remote -v
                    
                    echo.
                    echo Arquivos no repositorio:
                    dir
                    
                    echo.
                    echo Testando curl:
                    curl --version
                '''
            }
        }
        
        stage('2. Criar Pasta Documentacao') {
            steps {
                echo "Criando pasta documentacao..."
                
                bat '''
                    if not exist documentacao mkdir documentacao
                    echo Pasta criada
                '''
            }
        }
        
        stage('3. Baixar Visao Geral') {
            steps {
                echo "Baixando visao geral da API..."
                
                bat '''
                    echo URL: %API_URL%/api/download/%JOB_ID%/visao-geral
                    
                    curl -v -o documentacao/01_visao_geral.md ^
                        %API_URL%/api/download/%JOB_ID%/visao-geral
                    
                    echo.
                    echo Arquivo baixado:
                    dir documentacao\\01_visao_geral.md
                    
                    echo.
                    echo Primeiras 5 linhas do arquivo:
                    powershell -Command "Get-Content documentacao/01_visao_geral.md -Head 5"
                '''
            }
        }
        
        stage('4. Commit e Push') {
            steps {
                echo "Commitando no repositorio..."
                
                withCredentials([usernamePassword(
                    credentialsId: 'github-credentials',
                    usernameVariable: 'GIT_USER',
                    passwordVariable: 'GIT_TOKEN'
                )]) {
                    bat '''
                        git config user.name "Jenkins Bot"
                        git config user.email "jenkins@empresa.com"
                        
                        git add documentacao/01_visao_geral.md
                        
                        echo Status do Git:
                        git status
                        
                        git diff --staged --quiet
                        if errorlevel 1 (
                            echo.
                            echo Commitando...
                            git commit -m "docs: Adiciona visao geral do programa CALCSAL"
                            
                            echo.
                            echo Fazendo push...
                            git push https://%GIT_USER%:%GIT_TOKEN%@github.com/devjuannobrega/CALCSAL.git main
                            
                            echo.
                            echo Commit e push concluidos!
                        ) else (
                            echo Nenhuma mudanca para commitar
                        )
                    '''
                }
            }
        }
    }
    
    post {
        success {
            echo """
            
            ========================================
            PIPELINE CONCLUIDO COM SUCESSO!
            ========================================
            
            Arquivo baixado da API:
              Job ID: ${env.JOB_ID}
              Tipo: visao-geral
            
            Arquivo salvo em:
              documentacao/01_visao_geral.md
            
            Commitado no repositorio:
              https://github.com/devjuannobrega/CALCSAL
            
            Verifique em:
              https://github.com/devjuannobrega/CALCSAL/blob/main/documentacao/01_visao_geral.md
            
            ========================================
            
            """
        }
        
        failure {
            echo """
            
            ========================================
            PIPELINE FALHOU!
            ========================================
            
            Stage que falhou: ${env.STAGE_NAME}
            
            Verifique os logs acima!
            
            ========================================
            
            """
        }
        
        always {
            echo "Pipeline finalizado"
        }
    }
}
