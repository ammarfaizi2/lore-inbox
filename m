Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276934AbRJCJLb>; Wed, 3 Oct 2001 05:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276932AbRJCJLV>; Wed, 3 Oct 2001 05:11:21 -0400
Received: from mta.sara.nl ([145.100.16.144]:31916 "EHLO mta.sara.nl")
	by vger.kernel.org with ESMTP id <S276934AbRJCJLE>;
	Wed, 3 Oct 2001 05:11:04 -0400
Message-Id: <200110030911.LAA03639@zhadum.sara.nl>
X-Mailer: exmh version 2.1.1 10/15/1999
From: Remco Post <r.post@sara.nl>
To: "Dan Mann" <daniel_b_mann@hotmail.com>
cc: "Kernel List" <linux-kernel@vger.kernel.org>
Subject: Re: QNX Scheduler patch 
In-Reply-To: Message from "Dan Mann" <daniel_b_mann@hotmail.com> 
   of "Mon, 01 Oct 2001 12:19:50 EDT." <OE309IcVux1Zcn8TtEv00006b70@hotmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 03 Oct 2001 11:11:26 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can anyone tell me about experience with the QNX scheduler patch done way
> back for kernel 2.0.31?  I've been wanting to try it on a 2.4 series kernel
> (I'm looking for best possible interactive performance under X), and I want
> to know if it is worth porting to the 2.4 line.
> 
> Thanks,
> 
> Dan

I tried the patch once or twice. On small systems or systems under heavy load it did give a more responsive feeling on interactive applications. With more modern systems (I tested it on my PowerMac 7200/75) I think the difference is not worth the effort of porting the scheduler.

-- 
Met vriendelijke groeten,

Remco Post

SARA - Stichting Academisch Rekencentrum Amsterdam
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the computer
industry. Not that that tells us very much of course - the computer industry
didn't even foresee that the century was going to end." -- Douglas Adams


