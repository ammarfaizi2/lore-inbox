Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266948AbSLDIbm>; Wed, 4 Dec 2002 03:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266949AbSLDIbm>; Wed, 4 Dec 2002 03:31:42 -0500
Received: from mail.science.uva.nl ([146.50.4.51]:36304 "EHLO
	mail.science.uva.nl") by vger.kernel.org with ESMTP
	id <S266948AbSLDIbl>; Wed, 4 Dec 2002 03:31:41 -0500
Message-Id: <200212040836.gB48axK12602@mail.science.uva.nl>
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
Content-Type: text/plain; charset=US-ASCII
From: Rudmer van Dijk <rudmer@legolas.dynup.net>
Reply-To: rudmer@legolas.dynup.net
To: davej@codemonkey.org.uk
Subject: Re: [CFT][2.5] AGPGART reworking.
Date: Wed, 4 Dec 2002 09:36:54 +0100
X-Mailer: KMail [version 1.3.2]
References: <200212031837.gB3IbvQT008482@noodles.internal>
In-Reply-To: <200212031837.gB3IbvQT008482@noodles.internal>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
X-Spam-Rating: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 December 2002 19:37, davej@codemonkey.org.uk wrote:
> As per private discussion with Linus over the last few days,
> I've reworked the AGPGART driver considerably.  There's likely
> some gotchas left here, so I'd appreciate testers/code-review
> of this quite large change (>200KB worth of diff, but several
> files get moved about a bit).
 
I'm running it now, see no difference, except for the version in dmesg...

<snip>
Linux agpgart interface v1.0 (c) Dave Jones
agpgart: Detected SiS 735 chipset
agpgart: Maximum main memory to use for agp memory: 203M
spurious 8259A interrupt: IRQ7.
agpgart: AGP aperture is 32M @ 0xd0000000
[drm] AGP 1.0 on SiS @ 0xd0000000 32MB
[drm] Initialized mga 3.1.0 20021029 on minor 0
<snip>

	Rudmer
