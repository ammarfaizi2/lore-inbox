Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272467AbRIKP03>; Tue, 11 Sep 2001 11:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272483AbRIKP0T>; Tue, 11 Sep 2001 11:26:19 -0400
Received: from ns.caldera.de ([212.34.180.1]:31105 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S272467AbRIKP0H>;
	Tue, 11 Sep 2001 11:26:07 -0400
Date: Tue, 11 Sep 2001 17:26:21 +0200
Message-Id: <200109111526.f8BFQLr25266@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: david.balazic@uni-mb.si (David Balazic)
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBMs LVM ?
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <3B9E255C.8943D6BB@uni-mb.si>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.2 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3B9E255C.8943D6BB@uni-mb.si> you wrote:
> Hi!

> I heard rumors about IBM porting their LVM code from AIX to Linux.

IBM has an OpenSource volume manager called evms, and although
it does support AIX Volumes is has it's root in IBM's OS/2
volume management system.  (I believe someone at IBM thinks of PCs
when hearing Linux so all their ports start from OS/2...)

> I guess the current LVM code is not from IBM ?

The current code is from Heinz Maulshagen and now matained by Sistina,
the company he works for.

> Will it be replaced with the one from IBM ?

ALthough the current LVM has its's issues I hope not so - the current
EVMS is the best example on hhow to not write kernel subsystems.

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
