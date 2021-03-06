import cherrypy
import psycopg2
import pprint

class DatabaseConsult(object):
    @cherrypy.expose
    def index(self):
        host = "host="+"<%= @ip_database %>"+" "
        port = "port="+str(5432)+" "
        db = "dbname="+'swn'+" "
        user = "user="+'pi'+" "
        passwd = "password="+'security++'+" "

        conn_string = host+port+db+user+passwd
        conn = psycopg2.connect(conn_string)
        cursor = conn.cursor()
        cursor.execute("SELECT * FROM devices")
        records = cursor.fetchall()
        #pprint.pprint(records)
        #print((records['device_name']))
        return "This are database values"+" id_divice: "+str(records[0][0]) + " name_device: "+str(records[0][1])

    cherrypy.config.update({'server.socket_host': '<%= @ip_server %>', 'server.socket_port': <%= @port_server %>})
if __name__ == '__main__':
    cherrypy.quickstart(DatabaseConsult())


