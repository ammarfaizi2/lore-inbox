Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269472AbUICBRG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269472AbUICBRG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 21:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269479AbUICArr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:47:47 -0400
Received: from 69-18-3-179.lisco.net ([69.18.3.179]:61110 "EHLO slaphack.com")
	by vger.kernel.org with ESMTP id S269465AbUICAnq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:43:46 -0400
Message-ID: <4137BE36.5020504@slaphack.com>
Date: Thu, 02 Sep 2004 19:43:34 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040813)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Neukum <oliver@neukum.org>
CC: Spam <spam@tnonline.net>, Hans Reiser <reiser@namesys.com>,
       Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org> <4136E0B6.4000705@namesys.com> <1117111836.20040902115249@tnonline.net> <200409021309.04780.oliver@neukum.org>
In-Reply-To: <200409021309.04780.oliver@neukum.org>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Oliver Neukum wrote:
| Am Donnerstag, 2. September 2004 11:52 schrieb Spam:
|
|>  Btw, version control for ordinary files would be a great feature. I
|>  think something like it is available through Windows 2000/3 server.
|>  Isn't it called "Shadow Copies". It works over network shares. :)
|>
|>  It allows you to restore previous versions of the file even if you
|>  delete or overwrite it.
|
|
| There's no need to do that in kernel, unless you want to be able
| to force it unto users.

And on apps.  Should I teach OpenOffice.org to do version control?
Seems a lot easier to just do it in the kernel, and teach everything to
do version control in one fell swoop.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQTe+NXgHNmZLgCUhAQLW+RAAnoQIQLXSd2vQudOKAaLgXXCxoa+gEWIq
zcNd+bIWPuQxwcZYlqbs/pDFiDky3XqLRaZv8PZx++rs9mMnv36eAtMX7uUp3egz
MxymeDDI796wtsDDBGcZtO+WwmqJ0fPgQMN/Q237s2yccPGJoDIVle9mzZAfNIdO
RDdLq142D+0t1iqfiVqaA+NgkArrGhcr0Hs/3TdviJX30gPL/Jm9eOvc3H3NgIQu
XToDQB1UnLoyiIwc16IY4ZxYoxf1YnFtrivZb+YgC61mIQLeqJMjixCAtBVzAfKN
2GmlsnfWcMCgXSEX8imkoNSLcmkv886+esGXZVzBbY1/Qg/f5MCXZilbb8e6+4I9
U4ReEUg5fGJW8JyKAXqKGyvbC/lim55Vgcjp/J8mrhUa3Q3cwPKoi2GKNRcbdpT/
pPB2SADA1eNrmFyGB7kLcqt0F9i4fIyTrItpHq9+m72OdFEze2OnWn+eIY8dRut7
SaGTq6ZEYtkH8oWT9xSXp1d2TUxeSVTdx8EffIIdwXAVOO0Z9xd71MJPLMp3VOMH
Qld4gjYjKFzwj3QlcWcsiVhk6Zq2fmqoOCQNfxhBzH1Le3v0F0ugammkQUXtRAub
dKEWxGfkDGOwviJXKeckDNn98x88vh7C/7gxpAOIcVSRDhEV+MDWIfMMvotE/lxe
393hENsXOgQ=
=g+3J
-----END PGP SIGNATURE-----
