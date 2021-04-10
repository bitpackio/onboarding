FROM golang:1.16.3-buster AS build

WORKDIR /src/
COPY src /src/
RUN CGO_ENABLED=0 go build -o /bin/onboarding-backend

FROM scratch
COPY --from=build /bin/onboarding-backend /bin/onboarding-backend
ENTRYPOINT ["/bin/onboarding-backend"]
