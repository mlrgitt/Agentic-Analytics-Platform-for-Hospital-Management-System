{% macro column_exists(relation, column_name) %}

    {% set cols = adapter.get_columns_in_relation(relation) %}

    {% for col in cols %}
        {% if col.name == column_name %}
            {{ return(True) }}
        {% endif %}
    {% endfor %}

    {{ return(False) }}

{% endmacro %}