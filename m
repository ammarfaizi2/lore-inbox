Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030270AbVLFWD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030270AbVLFWD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbVLFWD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:03:59 -0500
Received: from main.gmane.org ([80.91.229.2]:6069 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030270AbVLFWD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:03:58 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicolas Mailhot <nicolas.mailhot@laposte.net>
Subject: Re: Linux in a binary world... a doomsday scenario
Date: Tue, 6 Dec 2005 21:39:19 +0000 (UTC)
Message-ID: <loom.20051206T220254-691@post.gmane.org>
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>  <20051205121851.GC2838@holomorphy.com>  <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org>  <20051206030828.GA823@opteron.random>  <f0cc38560512060307m2ccc6db8xd9180c2a1a926c5c@mail.gmail.com>  <1133869465.4836.11.camel@laptopd505.fenrus.org>  <4394ECA7.80808@didntduck.org> <1133880581.4836.37.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 81.64.157.3 (Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.8) Gecko/20051129 Fedora/1.5-1 Firefox/1.5)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan <at> infradead.org> writes:

> There are lots of opportunities to put pressure on vendors, either
> direct or indirect. Nvidia has a support department. If they get enough
> calls / letters about their solution not being good enough, they're more
> likely to consider the rearchtect solution. 

Indeed a single centralized complete online hardware database (with hardware
rated according to driver support level) would go a long way to put real
pressure on vendors. We know how to set up one for gnome/kde themes surely it'd
be possible to create one for hardware ? (not the current nebulae of
semi-complete overlapping projects, menuconfig entries, blog notes, linux-kernel
notifications)

But this requires _kernel_ _people_ cooperation. You're the ones who know what
works and what doesn't. You're the ones who know which corporations are helpful.
You're the first people users contact when they have new hardware they'd like to
make work. You're the ones who know which drivers you're currently working on.

The PCI ID database can be maintained without kernel people intervention. A
"linux-friendly hardware" database can not.

Right now getting hardware advice is a long and painful process. Hardware that
works is only semi-documented. Hardware which doesn't isn't at all. Users have
to comb numerous on-line databases and mail archives (full of obsolete/wrong
info) to spec a single linux-friendly system. Few people bother to answer
hardware advice requests on mailing lists.

Linux users could reward friendly hardware makers if only you bothered to point
them the right way. That is :
- list publicly working hardware as soon as the kernel driver is ready
- list publicly non-working hardware as soon as someone enquires for a reference
which does not work.

There's no magic.

Hardware makers do all kinds of stupid stuff to please review sites. Review
sites are influential because lots of people buy stuff based on their advice.
Lots of people follow review site advice because review sites centralize info
about all kinds of hardware, so you don't have to comb the web to find it.

As Groklaw has shown - if you manage to do complete coverage of a subject, even
an obscure subject like IP laws or Linux drivers, you suddenly get quoted
everywhere. But to reach that stage you mustn't go halfways but record
meticulously info about all the hardware you know of.

-- 
Nicolas Mailhot

