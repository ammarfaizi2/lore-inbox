Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261270AbULTIH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261270AbULTIH3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 03:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbULTIFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 03:05:19 -0500
Received: from msg-mx1.usc.edu ([128.125.137.6]:43140 "EHLO msg-mx1.usc.edu")
	by vger.kernel.org with ESMTP id S261505AbULTH2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 02:28:51 -0500
Date: Sun, 19 Dec 2004 23:28:35 -0800
From: Phil Dibowitz <phil@ipom.com>
Subject: Re: [linux-usb-devel] Re: RFC: [2.6 patch] let BLK_DEV_UB depend on
 EMBEDDED
In-reply-to: <20041219223723.3e861fc5@lembas.zaitcev.lan>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Message-id: <41C67F23.2080303@ipom.com>
MIME-version: 1.0
Content-type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary=------------enig0CCD6FD3A9E0DB4B62DDC95E
X-Accept-Language: en-us, en
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20041220001644.GI21288@stusta.de>
 <20041220003146.GB11358@kroah.com> <20041220013542.GK21288@stusta.de>
 <20041219205104.5054a156@lembas.zaitcev.lan> <41C65EA0.7020805@osdl.org>
 <20041220062055.GA22120@one-eyed-alien.net>
 <20041219223723.3e861fc5@lembas.zaitcev.lan>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0CCD6FD3A9E0DB4B62DDC95E
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Pete Zaitcev wrote:
> On Sun, 19 Dec 2004 22:20:55 -0800, Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:
> 
> 
>>I can tell you that this has turned into the single largest source of bug
>>reports/complaints about usb-storage.  Something has to be done.  I just
>>don't know what.
> 
> 
> Is it that bad, really? Honestly, I could not imagine users can be so dumb.
> The option defaults to off. There is a warning in the Kconfig. And yet they
> first enable it and then complain about it. I don't know what to do about
> it, either.

I was told this was enabled in the mandrake 2.6.9 kernel. I haven't 
confirmed that.

Yes, users are very stupid. Ever worked in tech support?

-- 
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."
  - Benjamin Franklin, 1759


--------------enig0CCD6FD3A9E0DB4B62DDC95E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBxn8jN5XoxaHnMrsRAtChAJ9J5Wi0nDXfg3+rf6h7Vu6LPqvQlwCfTqwx
ur7xoU63t7OqGJhDXuQssCI=
=h+ig
-----END PGP SIGNATURE-----

--------------enig0CCD6FD3A9E0DB4B62DDC95E--
