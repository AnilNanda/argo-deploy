argo-deploy is a private github action used to update image tag in helm values file

Action has to be invoked with below parameters

image_id
git_password
app_name
service_name
environment


Example

      - name: Get private action
        uses: actions/checkout@v2
        with:
          repository: <org>/argo-deploy
          token: ${{ secrets.GIT_PASSWORD }} # stored in GitHub secrets
          path: .github/actions/argo-deploy
          
      - name: Update image tag in helm chart
        uses: ./.github/actions/argo-deploy # Uses an action in the root directory
        id: deployment-update
        with:
          image_id: ${{ steps.login-ecr.outputs.registry }}/${{ env.SERVICE }}:${{ github.sha }}
          git_password: ${{ secrets.GIT_PASSWORD }}
          app_name: redis
          service_name: redis
          environment: dev
