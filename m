Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261303AbSJLRvt>; Sat, 12 Oct 2002 13:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261304AbSJLRvt>; Sat, 12 Oct 2002 13:51:49 -0400
Received: from ns3.neutech.fi ([194.100.130.126]:41989 "HELO cyplex.neutech.fi")
	by vger.kernel.org with SMTP id <S261303AbSJLRvt>;
	Sat, 12 Oct 2002 13:51:49 -0400
Date: Sat, 12 Oct 2002 20:57:37 +0300 (EEST)
From: Toni Mattila <tontsa@neutech.fi>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lk2.2.22 and IO-apic problem (dell poweredge)
In-Reply-To: <1034443302.15079.0.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44L0.0210122054280.12491-100000@cyclone.neutech.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

On 12 Oct 2002, Alan Cox wrote:
> On Sat, 2002-10-12 at 13:51, Toni Mattila wrote:
> > I have small issue with 2.2.22 kernel with Dell Poweredge 2600 server.
> > 
> > It finds 5 IO-apics and complains about max reached. What happens is that
> > it falls back to XT-PIC and now scsi/ethernet is on same IRQ..
> 
> 2.2 does not support multiprocessor pentium IV.

Does lk2.2 lack something substansial on P-IV SMP arena, or is it just 
matter of back porting some small bits from 2.4?

I'm bit worried about running lk2.4 on hybrid shell/webhost/mysql box.

Cheers,
Toni Mattila


