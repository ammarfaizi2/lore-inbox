Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261349AbVAaTrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261349AbVAaTrH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVAaTpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:45:33 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:17670 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261335AbVAaToE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:44:04 -0500
Message-Id: <200501311942.j0VJgIYs016952@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Adrian Bunk <bunk@stusta.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Lorenzo =?iso-8859-1?Q?Hern=E1ndez_Garc=EDa-Hierro?= 
	<lorenzo@gnu.org>,
       Stephen Hemminger <shemminger@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, netdev@oss.sgi.com,
       Hank Leininger <hlein@progressive-comp.com>
Subject: Re: [PATCH] OpenBSD Networking-related randomization port 
In-Reply-To: Your message of "Mon, 31 Jan 2005 17:50:25 +0100."
             <20050131165025.GN18316@stusta.de> 
From: Valdis.Kletnieks@vt.edu
References: <1106932637.3778.92.camel@localhost.localdomain> <20050128100229.5c0e4ea1@dxpl.pdx.osdl.net> <1106937110.3864.5.camel@localhost.localdomain> <20050128105217.1dc5ef42@dxpl.pdx.osdl.net> <1106944492.3864.30.camel@localhost.localdomain> <1106945266.7776.41.camel@laptopd505.fenrus.org> <200501290915.j0T9FkVY012948@turing-police.cc.vt.edu>
            <20050131165025.GN18316@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1107200537_32560P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 31 Jan 2005 14:42:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1107200537_32560P
Content-Type: text/plain; charset=us-ascii

On Mon, 31 Jan 2005 17:50:25 +0100, Adrian Bunk said:
> On Sat, Jan 29, 2005 at 04:15:43AM -0500, Valdis.Kletnieks@vt.edu wrote:

> > Note that obsd_rand.c started off life as a BSD-licensed file - I was told
> > that was a show-stopper when I submitted basically the same patch a while back.
> >...
> 
> At least the three clause BSD license is GPL compatible.

The copy of obsd_rand.c I have hass the problematic 4-clause version.  It looks
to me like we'd need to get Michael Shalayeff, Theodore T'so, and Niels Provos
to all agree to re-license under the 3-clause variant.  Using Arjan's code is
most likely the better approach...

--==_Exmh_1107200537_32560P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFB/ooZcC3lWbTT17ARAgbcAJ0Qn3ivh/rz9hIRaA4/ZaB4oZrx9wCdGXJL
VqYqh5yoLkS51NMtBgzmfys=
=rgm9
-----END PGP SIGNATURE-----

--==_Exmh_1107200537_32560P--
