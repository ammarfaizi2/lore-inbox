Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130493AbRDGTcR>; Sat, 7 Apr 2001 15:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130507AbRDGTcI>; Sat, 7 Apr 2001 15:32:08 -0400
Received: from lacrosse.corp.redhat.com ([207.175.42.154]:37680 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S130493AbRDGTbz>; Sat, 7 Apr 2001 15:31:55 -0400
Date: Sat, 7 Apr 2001 20:31:42 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Gunther Mayer <Gunther.Mayer@t-online.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mj@suse.cz,
        reinelt@eunet.at
Subject: Re: PATCH for Broken PCI Multi-IO in 2.4.3 (serial+parport)
Message-ID: <20010407203142.G3280@redhat.com>
In-Reply-To: <3ACECA8F.FEC9439@eunet.at> <3ACED679.7E334234@mandrakesoft.com> <20010407111419.B530@redhat.com> <3ACF5F9B.AA42F1BD@t-online.de> <20010407200340.C3280@redhat.com> <3ACF6920.465635A1@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="UTZ8bGhNySVQ9LYl"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ACF6920.465635A1@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Sat, Apr 07, 2001 at 03:23:12PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--UTZ8bGhNySVQ9LYl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 07, 2001 at 03:23:12PM -0400, Jeff Garzik wrote:

> It's just ugly to keep hacking in special cases to handle hardware
> that is multifunction like this.

I just don't want it to be a huge chore to add support for these
cards.

Would everyone be happy if (say) drivers/parport/parport_serial.c had
a table and a generic version of your example function, so that the
table somehow described the multifunction cards out there?

Tim.
*/

--UTZ8bGhNySVQ9LYl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6z2sdONXnILZ4yVIRAsY+AJ9E7KjrUlYj1OgpLWUvklDB2ZPLFQCfQOcA
JbOPFnnpHZWW5MWtadivOv8=
=L2le
-----END PGP SIGNATURE-----

--UTZ8bGhNySVQ9LYl--
