Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273615AbRIUQdL>; Fri, 21 Sep 2001 12:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273617AbRIUQdB>; Fri, 21 Sep 2001 12:33:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25605 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S273615AbRIUQcv>; Fri, 21 Sep 2001 12:32:51 -0400
Subject: Re: [PATCH] Preemption Latency Measurement Tool
To: jussi.laako@kolumbus.fi (Jussi Laako)
Date: Fri, 21 Sep 2001 17:36:17 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        roger.larsson@norran.net (Roger Larsson),
        oxymoron@waste.org (Oliver Xymoron),
        Dieter.Nuetzel@hamburg.de (Dieter =?iso-8859-1?Q?N=FCtzel?=),
        stefan@space.twc.de (Stefan Westerfeld), rml@tech9.net (Robert Love),
        andrea@suse.de (Andrea Arcangeli),
        linux-kernel@vger.kernel.org (linux-kernel),
        reiserfs-list@namesys.com (ReiserFS List)
In-Reply-To: <3BAB69CF.A3F9D217@kolumbus.fi> from "Jussi Laako" at Sep 21, 2001 07:24:47 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15kTHl-0000Pp-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Only "soundcards", that cheap crap like SoundBlaster. Professional
> lowlatency soundcards usually have something like 128-512 samples per
> channel for 24-bit (32-bit data) 96 kHz 8 channels...

Then the problem space isnt interesting. Many graphics cards will hog the
PCI bus for longer than that
