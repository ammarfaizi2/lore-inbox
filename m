Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750923AbVKFOur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750923AbVKFOur (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 09:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbVKFOur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 09:50:47 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:1200 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1750914AbVKFOuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 09:50:46 -0500
Message-ID: <436E181D.6010507@t-online.de>
Date: Sun, 06 Nov 2005 15:50:05 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Harald Dunkel <harald.dunkel@t-online.de>, 333052@bugs.debian.org
CC: Pozsar Balazs <pozsy@uhulinux.hu>, Kay Sievers <kay.sievers@vrfy.org>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Bug#333052: 2.6.14, udev: unknown symbols for ehci_hcd
References: <436CD1BC.8020102@t-online.de> <20051105173104.GA31048@vrfy.org> <20051105184802.GB25468@ojjektum.uhulinux.hu> <436DA120.9040004@t-online.de>
In-Reply-To: <436DA120.9040004@t-online.de>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD725E6A9BDA190D84892FB01"
X-ID: XNNdzYZXwe0-QEfd4-D9q3KNyDZbaFbPXh4M2axgvnaa1vL4AF4McO
X-TOI-MSGID: cf8a542f-4280-4dc9-af8a-dde1d9020e09
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD725E6A9BDA190D84892FB01
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Harald Dunkel wrote:
> 
> For testing I have added it to Debian's
> module-init-tools 3.2-pre9. Works for me.
> 

No, it doesn't. After the 3rd reboot the
problem was back.


Regards

Harri

--------------enigD725E6A9BDA190D84892FB01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDbhgmUTlbRTxpHjcRAnJ4AJ9th+WX7Gd/3z+kwixvK8dM0pgKGACfSZdD
1tecYJSB10ht+DC8hjefnWQ=
=Yzid
-----END PGP SIGNATURE-----

--------------enigD725E6A9BDA190D84892FB01--
