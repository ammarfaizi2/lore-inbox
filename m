Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289255AbSA2N2p>; Tue, 29 Jan 2002 08:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289296AbSA2N2f>; Tue, 29 Jan 2002 08:28:35 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:9491 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S289255AbSA2N2S>; Tue, 29 Jan 2002 08:28:18 -0500
Subject: Re: A modest proposal -- We need a patch penguin
To: mingo@elte.hu
Date: Tue, 29 Jan 2002 13:40:50 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        dalecki@evision-ventures.com (Martin Dalecki),
        torvalds@transmeta.com (Linus Torvalds),
        linux-kernel@vger.kernel.org (linux-kernel),
        axboe@suse.de (Jens Axboe)
In-Reply-To: <Pine.LNX.4.33.0201291603520.7176-100000@localhost.localdomain> from "Ingo Molnar" at Jan 29, 2002 04:18:39 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16VYVH-0003x8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> for code areas where there is not active maintainer or the maintainer has
> ignored patches? Eg. the majority of the kdev transition patches went in
> smoothly.

No you merely aren't watching. Most of the maintainers btw are ignoring 2.5
if you do some asking. And a measurable number of the listed maintainer
addresses just bounce.

> Another reason is that you do much more housekeeping in areas that are not
> actively maintained. But wouldnt it be better if there were active
> maintainers in those areas as well so you could spend more time on eg.
> doing the kernel-stack coloring changes?

There never will be maintainers proper for large amounts of stuff, and the
longer Linus deletes and ignores everything from someone new the less people
will bother sending to him. Just look at the size of the diff set between all
the vendor kernels and Linus 2.4.x trees before the giant -ac merge.

Think gcc, think egcs. History is merely beginning to repeat itself

Alan
