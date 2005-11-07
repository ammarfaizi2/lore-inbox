Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbVKGGBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbVKGGBQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 01:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbVKGGBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 01:01:16 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:32160 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S964786AbVKGGBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 01:01:15 -0500
Message-ID: <436EED92.9080003@t-online.de>
Date: Mon, 07 Nov 2005 07:00:50 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Marco d'Itri" <md@Linux.IT>
CC: 333052@bugs.debian.org, Pozsar Balazs <pozsy@uhulinux.hu>,
       Kay Sievers <kay.sievers@vrfy.org>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Bug#333052: 2.6.14, udev: unknown symbols for ehci_hcd
References: <436CD1BC.8020102@t-online.de> <20051105173104.GA31048@vrfy.org> <20051105184802.GB25468@ojjektum.uhulinux.hu> <436DA120.9040004@t-online.de> <436E181D.6010507@t-online.de> <20051106152924.GB16987@ojjektum.uhulinux.hu> <436E37E8.3070807@t-online.de> <20051106172128.GA8721@wonderland.linux.it>
In-Reply-To: <20051106172128.GA8721@wonderland.linux.it>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF1F7641E97792797838F7F4D"
X-ID: ZSvY+-ZcQeEQQhv4Gakj+xlh9-iFnt5OhEwKMOa41t43OvW10i53Zv
X-TOI-MSGID: d45f99f5-4bfa-4947-873c-43be4ee1f893
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF1F7641E97792797838F7F4D
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Marco d'Itri wrote:
> 
>>Are there several modprobe's running in parallel? Or does modprobe
> 
> Yes.
> 
Is this supposed to be synchronized in user space, or in the
kernel?

Regards

Harri

--------------enigF1F7641E97792797838F7F4D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDbu2YUTlbRTxpHjcRApjJAKCD776lSH/Mal8sS2IyYcDpfkB9awCgi01H
r4zA+W+cuvgctDMfqi6lXvE=
=m00t
-----END PGP SIGNATURE-----

--------------enigF1F7641E97792797838F7F4D--
