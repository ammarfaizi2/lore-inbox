Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130281AbQLUUvB>; Thu, 21 Dec 2000 15:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130442AbQLUUuw>; Thu, 21 Dec 2000 15:50:52 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:5391
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130281AbQLUUuk>; Thu, 21 Dec 2000 15:50:40 -0500
Date: Thu, 21 Dec 2000 12:19:37 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: safemode <safemode@voicenet.com>
cc: Zdenek Kabelac <kabi@fi.muni.cz>, xOr <xor@x-o-r.net>,
        linux-kernel@vger.kernel.org
Subject: Blow Torch (Re: lockups from heavy IDE/CD-ROM usage)
In-Reply-To: <3A426150.1545FC96@voicenet.com>
Message-ID: <Pine.LNX.4.10.10012211216060.566-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Dec 2000, safemode wrote:

> I get this on the 440LX with the same DMA timeout message.  Everyone says it's
> the board's fault as well.  Funny.   Anyways this happens accross just about
> any Dev kernel but more so in the -test12 and up versions. .   Test10 works
> fine without locking.  Blaming the hardware reminds me of the help given by
> some other company I can't seem to remember the name to.

29063507.pdf Page 22 sections 9,10
What is the Intel solution to the is system hang?

29063507.pdf Page 25 section 16
Is this erratum valid to include all PIIX4-AB/EB, PIIX3, and PIIX a/b.

It is the DAMN hardware and quit BITCHING.
I told everyone once that I was working on this issue.
If you think you can fix it before me, be my guest.

I have given you the INTEL doc numbers and the page and the section.
Go read.

Regards

Andre Hedrick
Linux ATA Development


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
