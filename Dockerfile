FROM dockerio.bin.t-mobile.at/python:2.7
WORKDIR "/opt/app"
COPY doSchemaValidation.sh rules.json /opt/app/
RUN apt update && pip install json-spec && chmod 775 doSchemaValidation.sh && mkdir schemas
ENTRYPOINT ["sh","doSchemaValidation.sh","/opt/app/schemas"]
CMD ["/opt/app/schemas/ValidationReport.txt"]


