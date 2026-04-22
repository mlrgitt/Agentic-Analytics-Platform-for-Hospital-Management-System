{% macro resolve_column(relation, candidates) %}

    {% set cols = adapter.get_columns_in_relation(relation) %}

    {% for col in cols %}
        {% if col.name in candidates %}
            {{ return(col.name) }}
        {% endif %}
    {% endfor %}

    {{ return('NULL') }}

{% endmacro %}