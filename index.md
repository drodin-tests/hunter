## Packages status

{% assign oses = "ubuntu, windows, macos" | split: ", " %}

<table>
<tr class="highlight">
    <th>Package</th>
    {% for os in oses %}
        <th>{{ os | capitalize }}</th>
    {% endfor %}
</tr>

{% for project in site.data.projects %}
<tr class="highlight">
    <td><strong>{{ project[0] }}</strong></td>
    {% for os in oses %}
    <td>
    {% for job in project[1] %}
        {% assign name = job.name | split: " " %}
        {% if name[2] contains os %}
        <a href="{{ job.html_url }}" class="{{ job.conclusion }}">{{ name[1] }}</a><br>
        {% endif %}
    {% endfor %}
    </td>
    {% endfor %}
</tr>
{% endfor %}
</table>