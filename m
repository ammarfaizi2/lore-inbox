Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276763AbRJHIlS>; Mon, 8 Oct 2001 04:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276770AbRJHIlK>; Mon, 8 Oct 2001 04:41:10 -0400
Received: from maild.telia.com ([194.22.190.101]:54995 "EHLO maild.telia.com")
	by vger.kernel.org with ESMTP id <S276763AbRJHIlE>;
	Mon, 8 Oct 2001 04:41:04 -0400
Message-ID: <3BC1D926.69D1AFED@canit.se>
Date: Mon, 08 Oct 2001 18:49:42 +0200
From: Kenneth Johansson <ken@canit.se>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.10-ac8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] emu10k1 and SMP
In-Reply-To: <3BC0D5F9.3C6DCF93@canit.se> <1002518015.999.93.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

> On Sun, 2001-10-07 at 18:23, Kenneth Johansson wrote:
> > I have a problem with my sblive card with some program when I compile
> > 2.4.10 and -ac8 for SMP.
> >
> > This happens with programs from loki and the machine stops or power down
> > (yes an actuall power down). I'am sure this is sound related as stuff
> > works if I don't load the emu10k1 driver and it only happens with SMP.
>
> Can you give a better description of the problem?
>
> Are you using the sblive driver from the kernel or CVS or ALSA?
>

The kernel.

>
> Does the problem go away if you recompile with CONFIG_SMP=n ?
>

Yes.

>
> What exactly happens? Oops?  Can you debug?  Reproduce?  Anything?
>

No oops . I get a power down or a hung system. I can reproduce this easy but
I can't get any information out of the system it is really dead it dose not
repond to anything even when hung and when it's powerd down it's kind of to
late to do something about it then.


