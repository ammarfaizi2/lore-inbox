Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270814AbRIFNxT>; Thu, 6 Sep 2001 09:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270818AbRIFNxJ>; Thu, 6 Sep 2001 09:53:09 -0400
Received: from mail2.aracnet.com ([216.99.193.35]:9480 "EHLO mail2.aracnet.com")
	by vger.kernel.org with ESMTP id <S270814AbRIFNxC>;
	Thu, 6 Sep 2001 09:53:02 -0400
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: page_launder() on 2.4.9/10 issue
Date: Thu, 6 Sep 2001 06:54:14 -0700
Message-ID: <HBEHIIBBKKNOBLMPKCBBOEMFDKAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <592148204.999786238@[10.132.112.53]>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm relatively new to the Linux kernel world and even newer to the list, so
forgive me if I'm asking a silly question or making a silly comment. It
seems to me, from what I've seen of this discussion so far, that the only
way one "tunes" Linux kernels at the moment is by changing code and
rebuilding the kernel. That is, there are few "tunables" that one can set,
based on one's circumstances, to optimize kernel performance for a specific
application or environment.

Every other operating system that I've done performance tuning on, starting
with Xerox CP-V in 1974, had such tunables and tools to set them. And quite
often, some of the tuning parameters can be set "on the fly", simply by
knowing the correct memory location to set and poking a new value into it.
No one "memory management scheme", for example, can be all things to all
tasks, and it seems to me that giving users tools to measure and control the
behavior of memory management, *preferably without having to recompile and
reboot*, should be a major priority if Linux is to succeed in a wide variety
of applications.

OK, I'll get off my soapbox now, and ask a related question. Is there a
mathematical model of the Linux kernel somewhere that I could get my hands
on?
--
M. Edward (Ed) Borasky, Chief Scientist, Borasky Research
http://www.borasky-research.net  http://www.aracnet.com/~znmeb
mailto:znmeb@borasky-research.com  mailto:znmeb@aracnet.com

Stand-Up Comedy: Because Man Does Not Live By Dread Alone

