Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263921AbTFPPfn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 11:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbTFPPfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 11:35:43 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:38790 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S263921AbTFPPfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 11:35:42 -0400
Date: Mon, 16 Jun 2003 11:46:02 -0400
From: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Subject: Re: Kernel 2.5.71 cannot unmount nfs
In-reply-to: <20030616085727.GA1331@in.ibm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: "Seifert Guido, gse" <Guido.Seifert@pentapharm.com>,
       linux-kernel@vger.kernel.org
Message-id: <20030616154602.GA2805@butterfly.hjsoft.com>
MIME-version: 1.0
Content-type: multipart/signed; boundary=OgqxwSJOaUobr8KG;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Content-disposition: inline
User-Agent: Mutt/1.5.4i
References: <0557B834CB410E4EB692BC78504D4C2C02F3EC@dc0011.pefade.pefa.local>
 <20030616085727.GA1331@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2003 at 02:27:27PM +0530, Dipankar Sarma wrote:
> Does this patch fix your problem ?
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.71/2.5=
=2E71-mm1/broken-out/rpc-depopulate-fix.patch

it's working beautifully for ME now.  thanks.
--=20
____________________}John Flinchbaugh{______________________
| glynis@hjsoft.com         http://www.hjsoft.com/~glynis/ |
~~Powered by Linux: Reboots are for hardware upgrades only~~

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+7eY6CGPRljI8080RAqbEAJ9NCUlVbudxsGmFkaO3hNR3n0ZCyACfRsu2
3SiDtStvPEFtiWAhzjVxtQY=
=+bzD
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--
