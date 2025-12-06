USE sql_project;

-- Contar el total de trabajos únicos
SELECT 
    COUNT(DISTINCT preferredLabel) AS total_trabajos_unicos
FROM 
    esco_occupation;
    
-- Listar los nombres de trabajos únicos
SELECT DISTINCT 
    preferredLabel
FROM 
    esco_occupation;

-- Trabajos más repetidos 
SELECT 
    preferredLabel,
    COUNT(*) AS Frecuencia
FROM 
    esco_occupation
GROUP BY 
    preferredLabel
ORDER BY 
    Frecuencia DESC
LIMIT 10;

-- Contar cuántos empleos hay por cada categoría del IscoGroup (CONTEO POR GRUPO)
SELECT 
    SUBSTRING(iscoGroup, 1, 1) AS Grupo_Principal,
    COUNT(*) AS Total_Por_Grupo
FROM 
    esco_occupation
GROUP BY 
    Grupo_Principal
ORDER BY 
    Total_Por_Grupo DESC;
    
 -- PreferredLabel y altLabels    
SELECT 
    preferredLabel,
    altLabels
FROM 
    esco_occupation;

-- Los 3 ISCO con más empleos 
SELECT
    SUBSTRING(iscoGroup, 1, 1) AS Grupo_Principal_ISCO,
    COUNT(*) AS Total_Ocupaciones
FROM
    esco_occupation
GROUP BY
    Grupo_Principal_ISCO
ORDER BY
    Total_Ocupaciones DESC
LIMIT 3;

-- Trabajos dentro de cada uno de esos 3 ISCO 
 -- Grupo 2
 SELECT
    preferredLabel AS Ocupacion,
    iscoGroup AS Codigo_ISCO_4_Digitos
FROM
    esco_occupation
WHERE
    SUBSTRING(iscoGroup, 1, 1) = '2'
ORDER BY
    preferredLabel;

  -- Grupo 3
SELECT
    preferredLabel AS Ocupacion,
    iscoGroup AS Codigo_ISCO_4_Digitos
FROM
    esco_occupation
WHERE
    SUBSTRING(iscoGroup, 1, 1) = '3'
ORDER BY
    preferredLabel;
    
    -- Grupo 7 
SELECT
    preferredLabel AS Ocupacion,
    iscoGroup AS Codigo_ISCO_4_Digitos
FROM
    esco_occupation
WHERE
    SUBSTRING(iscoGroup, 1, 1) = '7'
ORDER BY
    preferredLabel; 

-- Selección de base de datos a utilizar
USE sql_project;

-- Revisión del aspecto de cada tabla por separado
SELECT * FROM impacto_ia_empleos;
SELECT * FROM esco_occupation;

-- Estudio del número total de filas
SELECT COUNT(*) AS total_filas
FROM impacto_ia_empleos;

-- Diferentes puestos de trabajo analizados con la distribución de los datos
SELECT
	Job_Title,
	COUNT(*) AS people_num,
	AVG(Average_Salary) AS avg_salary,
	AVG(Years_Experience) AS avg_experience,
	AVG(AI_Exposure_Index) AS avg_ai_exposure,
	AVG(Tech_Growth_Factor) AS avg_tech_growth,
	AVG (Automation_Probability_2030) AS avg_autom_prob
FROM impacto_ia_empleos
GROUP BY Job_Title
ORDER BY people_num DESC;

-- Diferentes niveles de educación analizados con la distribución de los datos
SELECT
	Education_level,
	COUNT(*) AS people_num,
	AVG(Average_Salary) AS avg_salary,
	AVG(Years_Experience) AS avg_experience,
	AVG(AI_Exposure_Index) AS avg_ai_exposure,
	AVG(Tech_Growth_Factor) AS avg_tech_growth,
	AVG (Automation_Probability_2030) AS avg_autom_prob
FROM impacto_ia_empleos
GROUP BY Education_level
ORDER BY people_num DESC;

-- Top 5 puestos de trabajo con mayor exposición a la inteligencia artificial de media
SELECT
	Job_Title,
	COUNT(*) AS people_num,
	AVG(Average_Salary) AS avg_salary,
	AVG(Years_Experience) AS avg_experience,
	AVG(AI_Exposure_Index) AS avg_ai_exposure,
	AVG(Tech_Growth_Factor) AS avg_tech_growth,
	AVG (Automation_Probability_2030) AS avg_autom_prob
FROM impacto_ia_empleos
GROUP BY Job_Title
ORDER BY avg_ai_exposure DESC
LIMIT 5;

-- Top 5 puestos de trabajo con mayor crecimiento de tecnología en su sector de media
SELECT
	Job_Title,
	COUNT(*) AS people_num,
	AVG(Average_Salary) AS avg_salary,
	AVG(Years_Experience) AS avg_experience,
	AVG(AI_Exposure_Index) AS avg_ai_exposure,
	AVG(Tech_Growth_Factor) AS avg_tech_growth,
	AVG (Automation_Probability_2030) AS avg_autom_prob
FROM impacto_ia_empleos
GROUP BY Job_Title
ORDER BY avg_tech_growth DESC
LIMIT 5;

-- Top 5 puestos de trabajo con mayor probabilidad de automatización de media
SELECT
	Job_Title,
	COUNT(*) AS people_num,
	AVG(Average_Salary) AS avg_salary,
	AVG(Years_Experience) AS avg_experience,
	AVG(AI_Exposure_Index) AS avg_ai_exposure,
	AVG(Tech_Growth_Factor) AS avg_tech_growth,
	AVG (Automation_Probability_2030) AS avg_autom_prob
FROM impacto_ia_empleos
GROUP BY Job_Title
ORDER BY avg_autom_prob DESC
LIMIT 5;

-- Comparación entre la categoría de riesgo de automatización con la exposición del puesto de trabajo a la inteligencia artificial
SELECT
	Risk_Category,
	AVG(AI_Exposure_Index) AS AI_Exposure_Index
FROM impacto_ia_empleos
GROUP BY Risk_Category
ORDER BY AI_Exposure_Index DESC;

-- Comparativa de la categoría de riesgo de automatización en función del puesto de trabajo
SELECT
    Job_Title,
    SUM(CASE WHEN Risk_Category = 'Low' THEN 1 ELSE 0 END) AS low,
    SUM(CASE WHEN Risk_Category = 'Medium' THEN 1 ELSE 0 END) AS medium,
    SUM(CASE WHEN Risk_Category = 'High' THEN 1 ELSE 0 END) AS high
FROM impacto_ia_empleos
GROUP BY Job_Title
ORDER BY high DESC;

-- Comparativa de la categoría de riesgo de automatización en función del nivel de educación
SELECT
    Education_Level,
    SUM(CASE WHEN Risk_Category = 'Low' THEN 1 ELSE 0 END) AS low,
    SUM(CASE WHEN Risk_Category = 'Medium' THEN 1 ELSE 0 END) AS medium,
    SUM(CASE WHEN Risk_Category = 'High' THEN 1 ELSE 0 END) AS high
FROM impacto_ia_empleos
GROUP BY Education_Level
ORDER BY high DESC;

-- Comparativa de la distribución del nivel de experiencia de cada puesto de trabajo
SELECT
    Job_Title,
    SUM(CASE WHEN Years_Experience < 1 THEN 1 ELSE 0 END) AS no_exp,
    SUM(CASE WHEN Years_Experience BETWEEN 1 AND 3 THEN 1 ELSE 0 END) AS junior,
    SUM(CASE WHEN Years_Experience BETWEEN 4 AND 7 THEN 1 ELSE 0 END) AS mid,
    SUM(CASE WHEN Years_Experience BETWEEN 8 AND 15 THEN 1 ELSE 0 END) AS senior,
    SUM(CASE WHEN Years_Experience > 15 THEN 1 ELSE 0 END) AS veteran
FROM impacto_ia_empleos
GROUP BY Job_Title
ORDER BY Job_Title;

-- Probabilidad de automatización y exposición a la inteligencia artificial de los puestos de trabajo en función de la categoría de años de experiencia
SELECT
    CASE
        WHEN Years_Experience < 1 THEN '0. Sin experiencia'
        WHEN Years_Experience BETWEEN 1 AND 3 THEN '1. Junior'
        WHEN Years_Experience BETWEEN 4 AND 7 THEN '2. Mid'
        WHEN Years_Experience BETWEEN 8 AND 15 THEN '3. Senior'
        ELSE '4. Veterano'
    END AS exp_category,
	AVG(AI_Exposure_Index) AS avg_ai_exposure,
	AVG (Automation_Probability_2030) AS avg_autom_prob
FROM impacto_ia_empleos
GROUP BY exp_category
ORDER BY exp_category ASC;
    
-- Comparación de categorías de experiencia con sus categorías de salarios
SELECT
	CASE
        WHEN Years_Experience < 1 THEN '0. Sin experiencia'
        WHEN Years_Experience BETWEEN 1 AND 3 THEN '1. Junior'
        WHEN Years_Experience BETWEEN 4 AND 7 THEN '2. Mid'
        WHEN Years_Experience BETWEEN 8 AND 15 THEN '3. Senior'
        ELSE '4. Veterano'
    END AS exp_category,
	SUM(CASE WHEN Average_Salary < 40000 THEN 1 ELSE 0 END) AS low,
    SUM(CASE WHEN Average_Salary BETWEEN 40000 AND 60000 THEN 1 ELSE 0 END) AS low_medium,
    SUM(CASE WHEN Average_Salary BETWEEN 60000 AND 80000 THEN 1 ELSE 0 END) AS medium,
    SUM(CASE WHEN Average_Salary BETWEEN 80000 AND 100000 THEN 1 ELSE 0 END) AS medium_high,
    SUM(CASE WHEN Average_Salary > 100000 THEN 1 ELSE 0 END) AS high
FROM impacto_ia_empleos
GROUP BY exp_category
ORDER BY exp_category ASC;

-- PARTE 2
-- Limpieza de datos 
SELECT 
    T1.Job_Title,
    T2.preferredLabel,
    T2.iscoGroup
FROM 
    impacto_ia_empleos AS T1
INNER JOIN 
    esco_occupation AS T2
ON 
    LOWER(TRIM(T1.Job_Title)) = LOWER(TRIM(T2.preferredLabel));

-- UNIÓN TABLAS Y CÁLCULO DEL RIESGO PROMEDIO POR GRUPO ISCO

WITH CombinedData AS (
    SELECT
        T1.Job_Title,
        T1.AI_Exposure_Index,
        T1.Automation_Probability_2030,
        T1.Risk_Category,
        T1.Average_Salary,
        -- Extraemos el Grupo ISCO principal (el primer dígito)
        -- Usamos SUBSTRING para obtener el primer carácter del código ISCO de 4 dígitos.
        SUBSTRING(T2.iscoGroup, 1, 1) AS ISCO_Group_1D
    FROM 
        impacto_ia_empleos AS T1
    INNER JOIN 
        esco_occupation AS T2
    ON 
        LOWER(TRIM(T1.Job_Title)) = LOWER(TRIM(T2.preferredLabel))
)
SELECT
    ISCO_Group_1D,
    -- Promedio de exposición a IA por grupo
    AVG(AI_Exposure_Index) AS Avg_AI_Exposure,
    -- Promedio de probabilidad de automatización por grupo
    AVG(Automation_Probability_2030) AS Avg_Automation_Prob,
    -- Número de trabajos clasificados en este grupo
    COUNT(*) AS Total_Jobs_Count
FROM
    CombinedData
GROUP BY
    ISCO_Group_1D
ORDER BY
    Avg_Automation_Prob DESC;
    
-- Riesgo VS Recompensa: Exposición a la IA, Salario y Nivel Educativo
SELECT
    T1.Education_Level,
    COUNT(*) AS Total_Puestos,
    AVG(T1.AI_Exposure_Index) AS Avg_AI_Exposure,
    AVG(T1.Automation_Probability_2030) AS Avg_Automation_Prob,
    AVG(T1.Average_Salary) AS Avg_Salary
FROM 
    impacto_ia_empleos AS T1
INNER JOIN 
    esco_occupation AS T2
ON 
    LOWER(TRIM(T1.Job_Title)) = LOWER(TRIM(T2.preferredLabel))
GROUP BY
    T1.Education_Level
ORDER BY
    Avg_AI_Exposure DESC;

