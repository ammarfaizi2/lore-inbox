Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266638AbUBEVHK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 16:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUBEVHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 16:07:09 -0500
Received: from mout2.freenet.de ([194.97.50.155]:47265 "EHLO mout2.freenet.de")
	by vger.kernel.org with ESMTP id S266638AbUBEVHD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 16:07:03 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: psmouse.c, throwing 3 bytes away
Date: Thu, 5 Feb 2004 22:06:48 +0100
User-Agent: KMail/1.6.50
References: <200402041820.39742.wnelsonjr@comcast.net> <200402051517.37466.murilo_pontes@yahoo.com.br> <20040205203840.GA13114@ucw.cz>
In-Reply-To: <20040205203840.GA13114@ucw.cz>
Cc: linux-kernel@vger.kernel.org, Murilo Pontes <murilo_pontes@yahoo.com.br>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200402052207.00423.mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 05 February 2004 21:38, you wrote:
> Hey, guys, could you possibly try to figure out what your machines have
> in common? I've switched all my computers to PS/2 mice so that I have a
> bigger chance to reproduce the problem, but it is not happening on any
> of them.

Hm, that's a good question. :)
As I said I had these error messages on 2.6.2-rc2, but now
on 2.6.2 I don't have them anymore. (at least until yet).
But could also have something to do with the switch from
KDE-cvsHEAD-december2003 to KDE-3.2. I don't know.

I'm compiling software and accessing the disk heavily today
(and yesterday) but I can't see the message anymore.
That's strange!

- -- 
Regards Michael Buesch  [ http://www.tuxsoft.de.vu ]

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAIrBzFGK1OIvVOP4RAs1SAKCHWBStoIZ119Zq7wAomnYC2R1ukACePqTH
o0HPu/uLewEvpUD52TzbWqw=
=RG51
-----END PGP SIGNATURE-----
