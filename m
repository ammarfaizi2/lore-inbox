Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261653AbTCGPhk>; Fri, 7 Mar 2003 10:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261654AbTCGPhk>; Fri, 7 Mar 2003 10:37:40 -0500
Received: from smtp.comcast.net ([24.153.64.2]:59045 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S261653AbTCGPhe>;
	Fri, 7 Mar 2003 10:37:34 -0500
Date: Fri, 07 Mar 2003 10:47:13 -0500
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Subject: 2.5.64: nfs module unknown symbols
To: linux-kernel@vger.kernel.org
Message-id: <20030307154713.GA23425@butterfly.hjsoft.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary="LZvS9be/3tNcYl/X";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

kernel reports no support for nfs when i try to mount.

Mar  7 02:00:15 density kernel: nfs: Unknown symbol nlmclnt_proc
Mar  7 02:00:15 density kernel: nfs: Unknown symbol rpc_new_task
Mar  7 02:00:15 density kernel: nfs: Unknown symbol rpc_proc_register
Mar  7 02:00:15 density kernel: nfs: Unknown symbol rpc_wake_up_task
Mar  7 02:00:15 density kernel: nfs: Unknown symbol xdr_write_pages
Mar  7 02:00:15 density kernel: nfs: Unknown symbol
rpc_shutdown_client
Mar  7 02:00:15 density kernel: nfs: Unknown symbol lockd_down
Mar  7 02:00:15 density kernel: nfs: Unknown symbol lockd_up
Mar  7 02:00:15 density kernel: nfs: Unknown symbol xdr_read_pages
Mar  7 02:00:15 density kernel: nfs: Unknown symbol rpc_sleep_on
Mar  7 02:00:15 density kernel: nfs: Unknown symbol rpc_init_task
Mar  7 02:00:15 density kernel: nfs: Unknown symbol xdr_encode_array
Mar  7 02:00:15 density kernel: nfs: Unknown symbol xdr_encode_pages
Mar  7 02:00:15 density kernel: nfs: Unknown symbol rpc_setbufsize
Mar  7 02:00:15 density kernel: nfs: Unknown symbol rpc_clnt_sigmask
Mar  7 02:00:15 density kernel: nfs: Unknown symbol
rpc_proc_unregister
Mar  7 02:00:15 density kernel: nfs: Unknown symbol rpc_call_sync
Mar  7 02:00:15 density kernel: nfs: Unknown symbol rpc_delay
Mar  7 02:00:15 density kernel: nfs: Unknown symbol rpc_execute
Mar  7 02:00:15 density kernel: nfs: Unknown symbol rpc_killall_tasks
Mar  7 02:00:15 density kernel: nfs: Unknown symbol rpciod_up
Mar  7 02:00:15 density kernel: nfs: Unknown symbol xprt_destroy
Mar  7 02:00:15 density kernel: nfs: Unknown symbol rpc_clnt_sigunmask
=2E..

CONFIG_NFS_FS=3Dm
CONFIG_NFS_V3=3Dy
CONFIG_NFS_V4=3Dy
CONFIG_NFSD=3Dm
CONFIG_NFSD_V3=3Dy
CONFIG_NFSD_V4=3Dy
CONFIG_NFSD_TCP=3Dy
CONFIG_SUNRPC=3Dm
CONFIG_SUNRPC_GSS=3Dm
CONFIG_RPCSEC_GSS_KRB5=3Dm
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy

--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+aL8BCGPRljI8080RAgzjAJ9ql5rXRds6x0eoJDu7i69mYaptmACgjyu/
Bfdm0sEsdy8i/Q9xCyg0+8M=
=zusK
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
