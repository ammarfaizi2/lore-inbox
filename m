Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271851AbRHUUOZ>; Tue, 21 Aug 2001 16:14:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271850AbRHUUOP>; Tue, 21 Aug 2001 16:14:15 -0400
Received: from [145.254.145.253] ([145.254.145.253]:20975 "HELO
	schottelius.org") by vger.kernel.org with SMTP id <S271849AbRHUUOD>;
	Tue, 21 Aug 2001 16:14:03 -0400
Message-ID: <3B82C0C5.4924A507@pcsystems.de>
Date: Tue, 21 Aug 2001 22:12:54 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Luigi Genoni <kernel@Expansa.sns.it>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: cpu not detected(x86)
In-Reply-To: <Pine.LNX.4.33.0108080148060.17173-100000@Expansa.sns.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Genoni wrote:

> On Tue, 7 Aug 2001, Nico Schottelius wrote:
>
> > Hello!
> >
> > I am trying to run 2.4.7 and have heavily problems with my cpu.
> > The kernel retected another speed at every start! I attached
> > three times CPUINFO. The cpu in reality is a p3 650 mhz speedstep.
> > (may switch down to 500 mhz, but 126 _not_).
> >
> > Who changed something in the 2.4.7 source ?
> > I am more or less unable to run X with netscape to write this email
> > with 126 Mhz!
> Sometimes i use an old Pentium 133 classic (no mmx), and it works, well to
> do this with X11 and netscape. I think we are starting to be used to PC
> that are too powerful. :) If you go to fast how can you see where you are
> going? ;)
> OK, it was a joke...
>
> I would like to know, if your CPU is on a laptop, are you sure that your
> power management works well?

No, seems like ACPI killed the cpu speed.
I can't undernstand why ACPI is not marked EXPERIMENTAL,
if those things are normal!

> Is it working ok with 2.4.6? and 2.4.8-pre3?

Sorry, only tested 2.4.7.
Maybe I can test 2.4.8 in the next days.


Nico

