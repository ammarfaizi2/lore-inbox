Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282064AbRLKRYw>; Tue, 11 Dec 2001 12:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282242AbRLKRYn>; Tue, 11 Dec 2001 12:24:43 -0500
Received: from ns.caldera.de ([212.34.180.1]:34732 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S282064AbRLKRYg>;
	Tue, 11 Dec 2001 12:24:36 -0500
Date: Tue, 11 Dec 2001 18:23:50 +0100
Message-Id: <200112111723.fBBHNoY14804@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: alan@lxorguk.ukuu.org.uk (Alan Cox)
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.16 & OOM killer screw up (fwd)
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <E16DqhI-0005vG-00@the-village.bc.nu>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E16DqhI-0005vG-00@the-village.bc.nu> you wrote:
>> > I'm not happy about your usage of magic numbers, either. So it is
>> > still running on solid 2.2.19 until further notice (or until Rik loses
>> > his patience. ;-) )
>> 
>> I've lost patience and have decided to move development away
>> from the main tree.  http://linuxvm.bkbits.net/   ;)
>
> Are your patches available in a format that is accessible using free
> software ?

As bitkeeper-ignorant I've found nice snapshots on
http://www.surriel.com/patches/.

For BSD advocates it might be a problem that these are unified diffs
that are only applyable with GPL-licensed patch(1) version..

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
