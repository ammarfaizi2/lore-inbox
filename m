Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132811AbRDXGPv>; Tue, 24 Apr 2001 02:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132813AbRDXGPl>; Tue, 24 Apr 2001 02:15:41 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:52512 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132811AbRDXGPU>; Tue, 24 Apr 2001 02:15:20 -0400
Date: Tue, 24 Apr 2001 08:15:13 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "Antwerpen, Oliver" <Antwerpen@netsquare.org>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Semi-OT] Dual Athlon support in kernel
Message-ID: <20010424081512.D16845@athlon.random>
In-Reply-To: <9DD550E9A9B0D411A16700D0B7E38BA4255520@mail.degrp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9DD550E9A9B0D411A16700D0B7E38BA4255520@mail.degrp.org>; from Antwerpen@netsquare.org on Tue, Apr 24, 2001 at 08:03:18AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2001 at 08:03:18AM +0200, Antwerpen, Oliver wrote:
> I am also highly interested in information about dual Athlon (which
> kernel/compiler/tools to use?), as we will get a dual Athlon sample before

kernel >= 2.4.3 (better >= 2.4.4pre2 for other rasons) compiled for K7 and
CONFIG_SMP=y, compiler as usual for the kernel gcc 2.95.[43] or egcs 1.1.2.

Andrea
