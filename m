Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317101AbSFBBVc>; Sat, 1 Jun 2002 21:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317098AbSFBBVb>; Sat, 1 Jun 2002 21:21:31 -0400
Received: from mail305.mail.bellsouth.net ([205.152.58.165]:35739 "EHLO
	imf05bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S317101AbSFBBVa>; Sat, 1 Jun 2002 21:21:30 -0400
Subject: Re: P4 hyperthreading
From: Louis Garcia <louisg00@bellsouth.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020602005003.GE14918@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Jun 2002 21:14:23 -0400
Message-Id: <1022980463.2427.3.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Did I forget to say this is a UP box? I just wanted to know if
hyperthreading is stable for a UP P4 box. Will acpismp=force still help?

Thanks, --Lou


On Sat, 2002-06-01 at 20:50, William Lee Irwin III wrote:
> On Sat, Jun 01, 2002 at 08:40:44PM -0400, Louis Garcia wrote:
> > How stable is hyperthreading under kernel-2.4.18? I compiled the kernel
> > for the Pentium4 and dmesg shows CPU0 and CPU1, but CPU1 is disabled.
> > How do I enable CPU1 and should I?? Do other libraries need to be updated
> > or is hyperthreading like having a two processor box?
> 
> acpismp=force seems to work on 2.4 here.
> 
> 
> Cheers,
> Bill


