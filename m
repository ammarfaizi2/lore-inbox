Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129677AbRCCTV6>; Sat, 3 Mar 2001 14:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129686AbRCCTVs>; Sat, 3 Mar 2001 14:21:48 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36619 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129677AbRCCTVf>; Sat, 3 Mar 2001 14:21:35 -0500
Subject: Re: simple question about patches
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Sat, 3 Mar 2001 19:24:32 +0000 (GMT)
Cc: davidge@jazzfree.com, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
        alan@redhat.com
In-Reply-To: <200103031914.f23JEIa85558@saturn.cs.uml.edu> from "Albert D. Cahalan" at Mar 03, 2001 02:14:18 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ZHdq-0003yb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Long ago, pre* and ac* patches were rare. Patches went from one

Umm wrong. -ac patches for 2.2 regularly did one a day

> line-by-line before the next one came out. Patches always applied
> easily with the (pre-POSIX?) patch command. Version numbers made

patch is Larry Wall

> Pre-patches go like this:
> 
> 200 kB         (great: read the patch)
> 200 kB + 200 kB of old stuff you already read   (ugh, read 1/2 of it)
> 200 kB + 400 kB of old stuff you already read   (too boring)

Of course people with at least one functioning braincell read the differences
between the two patches, or pick up the patch between the two (handily
maintained on www.bzimage.org for the Linux 2.4ac series)

> So you just want to apply a patch. Well, good luck. The patch command
> has changed over the years. It has some ugly heuristics it uses to
> find the most destructive way to misinterpret your command. Typically

You must be using a faulty version fo patch

> Get the old and new directory names to be the same length, so that
> POSIX and non-POSIX patch commands are more likely to behave the same.

You need at least patch 2.5 for anything. And since patch 2.5 has been out
for rather a few years now this is all ancient ancient history (and was never
relevant in the real world anyway)

Alan

