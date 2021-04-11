FROM golang:1.16.3-buster AS build
WORKDIR /src/
COPY src /src/
RUN go mod download 
RUN go mod verify
RUN CGO_ENABLED=0 go build -o /bin/onboarding-backend
RUN mkdir -p /etc/onboarding/
COPY etc/app.env /etc/onboarding/app.env

FROM scratch
COPY --from=build /etc/onboarding /etc/onboarding
COPY --from=build /bin/onboarding-backend /bin/onboarding-backend
ENTRYPOINT ["/bin/onboarding-backend"]
