Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbWHXQEQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbWHXQEQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 12:04:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWHXQEQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 12:04:16 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:60570 "EHLO
	mail.arcor.de") by vger.kernel.org with ESMTP id S1030278AbWHXQEP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 12:04:15 -0400
From: Prakash Punnoor <prakash@punnoor.de>
To: "Zhen Zhou" <linuxnb@gmail.com>
Subject: Re: 2.6.17 hangs during boot on ASUS M2NPV-VM motherboard
Date: Thu, 24 Aug 2006 18:04:01 +0200
User-Agent: KMail/1.9.4
Cc: "Andy Chittenden" <AChittenden@bluearc.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <AcamZU83D6YFwDlPRZGLtXEmxZel2wAJqNMg> <89E85E0168AD994693B574C80EDB9C27043F5EBA@uk-email.terastack.bluearc.com> <37a5ad990608240855w45cd8dcfm21edafd6cfe0631f@mail.gmail.com>
In-Reply-To: <37a5ad990608240855w45cd8dcfm21edafd6cfe0631f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2361511.TKMvmfEAng";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608241804.01489.prakash@punnoor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2361511.TKMvmfEAng
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Donnerstag 24 August 2006 17:55 schrieb Zhen Zhou:
> Why don't you think this is usb problem?
>
> I use motherboard ASUS M2NPV-MX, I use Fedora 5. I got the same
> problem that you had, after I upgrade kernel from 2.6.15-1.2054 to
> kernel-2.6.17-1.2174_FC5, it hung on boot:

Was it stable for you with 2.6.15 kernel? With gentoo live cd (it was 2.6.1=
5=20
or 2.6.16, don't remember) it wasn't for me. 2.6.18-rc4 is now stable for m=
e=20
once hacked out the acpi_skip_timer_override quirk, as I mentioned in anoth=
er=20
thread. But till now I got no response about that...
=2D-=20
(=B0=3D                 =3D=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart2361511.TKMvmfEAng
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE7c3xxU2n/+9+t5gRAtunAJwNhH6ZlTxUL8vH81B37xzSpqrk1ACfSEkP
TKtTgaUoeQCx3U/y+HL8UZU=
=C2hf
-----END PGP SIGNATURE-----

--nextPart2361511.TKMvmfEAng--
