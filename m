Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314080AbSGAIsm>; Mon, 1 Jul 2002 04:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSGAIsl>; Mon, 1 Jul 2002 04:48:41 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:19497 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S314080AbSGAIsl>; Mon, 1 Jul 2002 04:48:41 -0400
To: Ken Witherow <ken@krwtech.com>
Cc: Philip Wyett <philipwyett@dsl.pipex.com>, linux-kernel@vger.kernel.org
Subject: Re: Tyan 2460/Dual Athlon MP hangs
References: <Pine.LNX.4.44.0206302352320.340-100000@death>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 01 Jul 2002 02:40:16 -0600
In-Reply-To: <Pine.LNX.4.44.0206302352320.340-100000@death>
Message-ID: <m1ofdrrgcv.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ken Witherow <ken@krwtech.com>, <MISSING_MAILBOX_TERMINATOR@.SYNTAX-ERROR> writes:

> On Mon, 1 Jul 2002, Philip Wyett wrote:
> 
> > Hi,
> >
> > This issue has all the hallmarks of PSU problems. I had the same issue running
> 
> > dual Athlon MP's with a GeForce 4 Ti4600 until I switched the 400W PSU that
> > came with the case too an Enermax 550W beast. The basic Tyan approved PSU for
> > the 2460 is a M2463 (460W) unit when talking to my main vendor specifically
> > because of all the problems with lockups and failures to even POST (Power On
> > Self Test) etc.
> 
> I have seen it fail to properly post after rebooting and I figured it
> might be the ACPI problem I've seen people have before. I'll upgrade the
> PSU and see if that doesn't take care of the problem. Thanks to everyone
> for the advice :)

My memory says the 2460 doesn't supply enough voltage/power to both
cpus, so getting it to run stable is a challenge.

I have seen some systems where burn k7 would lock them in under a minute,
due to this.

Eric
