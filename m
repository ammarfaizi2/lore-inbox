Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281606AbRKMLax>; Tue, 13 Nov 2001 06:30:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281607AbRKMLao>; Tue, 13 Nov 2001 06:30:44 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:38837 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S281606AbRKMLag>; Tue, 13 Nov 2001 06:30:36 -0500
Date: Tue, 13 Nov 2001 11:30:29 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Lee Howard <faxguy@deanox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lp oops with kernel 2.4.15-pre2
Message-ID: <20011113113029.N25718@redhat.com>
In-Reply-To: <3.0.6.32.20011112165757.00e404b0@server.deanox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="wnBDZIh98Y6AWY8/"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3.0.6.32.20011112165757.00e404b0@server.deanox.com>; from faxguy@deanox.com on Mon, Nov 12, 2001 at 04:57:57PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--wnBDZIh98Y6AWY8/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 12, 2001 at 04:57:57PM -0700, Lee Howard wrote:

> Nov 12 12:02:44 zelda kernel: EIP:    0010:[kmem_cache_alloc+100/176]
[...]
> Nov 12 12:02:44 zelda kernel: Call Trace: [d_alloc+23/368] [sprintf+18/32]
> [sock_map_fd+153/352] [unix_create+92/112] [sock_create+214/256]=20
> Nov 12 12:02:44 zelda kernel:    [dentry_open+346/384] [sys_socket+41/80]
> [sys_socketcall+96/464] [do_page_fault+0/1200] [error_code+52/60]
> [system_call+51/56]=20

This doesn't seem to be lp- or parport-related.  What else was the
machine doing at the time?

Tim.
*/

--wnBDZIh98Y6AWY8/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE78QRUyaXy9qA00+cRAkMIAJ9B4+mpWHfCsD5SzJrF8FcAEw+n5gCeOUEW
bFHTXhWwDlgOfCf5x+mT3sk=
=2MWR
-----END PGP SIGNATURE-----

--wnBDZIh98Y6AWY8/--
