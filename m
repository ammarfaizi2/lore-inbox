Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750820AbVJAQrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750820AbVJAQrk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 12:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbVJAQrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 12:47:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:8871 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750820AbVJAQrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 12:47:39 -0400
X-Authenticated: #8834078
From: Dominik Karall <dominik.karall@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.14-rc2-mm2 (dma_timer_expiry)
Date: Sat, 1 Oct 2005 18:52:10 +0200
User-Agent: KMail/1.8.91
Cc: linux-kernel@vger.kernel.org
References: <20050929143732.59d22569.akpm@osdl.org>
In-Reply-To: <20050929143732.59d22569.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1930131.MX7rHKzEGG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200510011852.24094.dominik.karall@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1930131.MX7rHKzEGG
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 29 September 2005 23:37, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.14-rc2/=
2.
>6.14-rc2-mm2/

Since 2.6.14-rc2-mm2 these errors make my system hang, I didn't get such=20
errors before on this system.

hda: dma_timer_expiry: dma status =3D=3D 0x21
hda: DMA timeout error
hda: dma timeout error: status=3D0x50 { DriveReady SeekComplete }
ide: failed opcode was: unknown
hda: task_in_intr: status=3D0x59 { DriveReady SeekComplete DataRequest Erro=
r }
hda: task_in_intr: error=3D0x04 { DriveStatusError }
ide: failed opcode was: unknown
hda: task_in_intr: status=3D0x59 { DriveReady SeekComplete DataRequest Erro=
r }
hda: task_in_intr: error=3D0x04 { DriveStatusError }
ide: failed opcode was: unknown
hda: task_in_intr: status=3D0x59 { DriveReady SeekComplete DataRequest Erro=
r }
hda: task_in_intr: error=3D0x04 { DriveStatusError }
ide: failed opcode was: unknown
hda: task_in_intr: status=3D0x59 { DriveReady SeekComplete DataRequest Erro=
r }
hda: task_in_intr: error=3D0x04 { DriveStatusError }
ide: failed opcode was: unknown
ide0: reset: success
hda: dma_timer_expiry: dma status =3D=3D 0x21
hda: DMA timeout error
hda: dma timeout error: status=3D0x58 { DriveReady SeekComplete DataRequest=
 }
ide: failed opcode was: unknown
hda: dma_timer_expiry: dma status =3D=3D 0x21
hda: DMA timeout error
hda: dma timeout error: status=3D0x58 { DriveReady SeekComplete DataRequest=
 }
ide: failed opcode was: unknown
hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: dma_intr: status=3D0x58 { DriveReady SeekComplete DataRequest }
ide: failed opcode was: unknown
hda: DMA disabled
ide0: reset: success


domink

--nextPart1930131.MX7rHKzEGG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2-ecc0.1.6 (GNU/Linux)

iQCVAwUAQz6+yAvcoSHvsHMnAQKS1wP/fIL/F/llxn4p7ud/MiROafaCnet+3v4F
oh2u9xzykcQaA66mgSgRV6YYepLZ4ge7TJAoQFOvCSlccQZpggVP5ttGLS1oMbtI
5R+vwqesLpf7/lvMiHr6QwsguYn4wKvUTHqCR8RqGm5CfXcVMN0jA8OJ0BQwnRK9
radaxvIvTZo=
=lLoT
-----END PGP SIGNATURE-----

--nextPart1930131.MX7rHKzEGG--
