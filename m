Return-Path: <linux-kernel-owner+w=401wt.eu-S1751701AbXANW5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbXANW5F (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 17:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbXANW5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 17:57:05 -0500
Received: from iucha.net ([209.98.146.184]:51415 "EHLO mail.iucha.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702AbXANW5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 17:57:04 -0500
Date: Sun, 14 Jan 2007 16:57:01 -0600
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Jiri Kosina <jikos@jikos.cz>, linux-usb-devel@lists.sourceforge.net,
       Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] 2.6.20-rc4: known unfixed regressions (v2)
Message-ID: <20070114225701.GA6053@iucha.net>
References: <20070109214431.GH24369@iucha.net> <Pine.LNX.4.44L0.0701101052310.3289-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0701101052310.3289-100000@iolanthe.rowland.org>
X-GPG-Key: http://iucha.net/florin_iucha.gpg
X-GPG-Fingerprint: 5E59 C2E7 941E B592 3BA4  7DCF 343D 2B14 2376 6F5B
User-Agent: Mutt/1.5.13 (2006-08-11)
From: florin@iucha.net (Florin Iucha)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2007 at 10:54:34AM -0500, Alan Stern wrote:
> It's still possible that this is hardware related; perhaps some component
> just began to wear out.  If you return to an earlier kernel, does the=20
> problem go away?

As reported in my original e-mail and verified just minutes ago, the
copy succeeds with 2.6.19 (kernel.org vanilla, compiled with the same
config as 2.6.20-rcX).  I will begin bisecting between .19 and .20-rc1
after re-reading Jiri's messages.

florin

--=20
Bruce Schneier expects the Spanish Inquisition.
      http://geekz.co.uk/schneierfacts/fact/163

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFFqrU9ND0rFCN2b1sRArmSAJ4oPhDGhuZn1QQ7WDZpS6oqxphbDACghnOl
TbEgBHYyDSZSR7q9OoXHId4=
=3+W/
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
