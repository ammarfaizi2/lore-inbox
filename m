Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284644AbRLPPFF>; Sun, 16 Dec 2001 10:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284652AbRLPPEz>; Sun, 16 Dec 2001 10:04:55 -0500
Received: from host62-7-99-245.btinternet.com ([62.7.99.245]:28933 "EHLO
	Wasteland") by vger.kernel.org with ESMTP id <S284644AbRLPPEv>;
	Sun, 16 Dec 2001 10:04:51 -0500
Message-Id: <m16Fcpv-000DDtC@Wasteland>
Content-Type: text/plain; charset=US-ASCII
From: Matthew M <matthew.macleod@btinternet.com>
To: Jon Peatfield <J.S.Peatfield@damtp.cam.ac.uk>
Subject: Re: crypto api stuff
Date: Sun, 16 Dec 2001 15:03:31 +0000
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <vxju1urit0n.fsf@redmires.amtp.cam.ac.uk>
In-Reply-To: <vxju1urit0n.fsf@redmires.amtp.cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
X-Operating-System: Debian Linux 2.2 Kernel 2.5
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 16 December 2001 06:22, Jon Peatfield wrote:
> Having spent some time trying to decide which version of the crypto
> api patch is best to apply to recent 2.4.x kernels I wondered if any
> serious thought had been given to including this in the standard
> kernel tree for 2.5 (and maybe some future 2.4 perhaps if it proves
> stable in 2.5)?

AFAIK the crypto api is very broken... problems with block sizes and various 
other niggles that make it unlikely to ever become a part of the kernel. Have 
a look at:

    http://mail.nl.linux.org/linux-crypto/2001-07/msg00181.html
    http://mail.nl.linux.org/linux-crypto/2001-07/msg00189.html

*MatthewM*
- -- 

A closed mouth gathers no foot.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8HLfOzhSxTQTEoE0RAn7GAJ4th0B7oj4uvGjd8DBaUJ3303MCZwCfSr6I
oUvL/SL2x7mT5iiG6ybaWGI=
=xnOg
-----END PGP SIGNATURE-----
