Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbTEaVlg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 17:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264465AbTEaVlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 17:41:36 -0400
Received: from tehunlose.com ([68.15.181.213]:21378 "EHLO cerebellum")
	by vger.kernel.org with ESMTP id S264464AbTEaVle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 17:41:34 -0400
From: Zack Gilburd <zack@tehunlose.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21rc6-ac1 Nforce2 AGP+ATI FireGL v2.9.12=hard lock
Date: Sat, 31 May 2003 14:54:52 -0700
User-Agent: KMail/1.5.2
References: <3ED8E682.5020506@poczta.onet.pl>
In-Reply-To: <3ED8E682.5020506@poczta.onet.pl>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_vSS2+xTy2S6yO6b";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200305311454.55244.zack@tehunlose.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_vSS2+xTy2S6yO6b
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: signed data
Content-Disposition: inline

On Saturday 31 May 2003 10:29, Gutko wrote:
> Hi,
> Just compiled 2.4.21rc6-ac1 with Nforce2 AGP as module.
> Then tried to install Ati FGLRX 2.9.12 from
> http://www.schneider-digital.de/html/download_ati.html
> http://www.schneider-digital.de/download/ati/glx1_linux_X4.3.zip
> because Ati didn't released XFree 4.3 driver on their www yet.
>
> During install of this rpm i get something like this:
> "Patching drmP.h  FAILED, saving rejects to....."
> This *.rej file is in attachment.
> Then module loads normally. I can start X on this driver, but only in 2d.
> Trying to run Tuxracer and any other 3d game hardlocks my machine. 2d
> games works ok.
>
> Everything was OK on clean 2.4.21rc6 patched with this Nforce2 AGP patch.
> http://etudiant.epita.fr:8000/~nonolk/nforce-agp.diff
> but Dave Jones told me it is buggy.
>
> My machine
> Asus A7N8X-deluxe nforce2 mb
> 1 GB of ram
> Ati Radeon 9700 128M
> Agp aperature set to 128M in bios
> Mandrake 9.1
> XFree86  v4.3
>
> I'll be happy to provide more info if needed :)
>
> Gutko
<troll>
	does anyone else find it ironic that when he uses ATi FireGL stuff on an=20
nVidia chipset mobo, it hardlocks?  *snicker*
</troll>

mod me down -5 troll accordingly, thanks.
=2D-=20
Zack Gilburd
http://tehunlose.com

--Boundary-02=_vSS2+xTy2S6yO6b
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+2SSvp5pFZoJAq2wRAjnVAKCz4/IeJHelgdrVVP7/AALn0+sCoQCgk34M
wNGBuHdK7agK314ME6BeARQ=
=vG7G
-----END PGP SIGNATURE-----

--Boundary-02=_vSS2+xTy2S6yO6b--

