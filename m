Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262737AbSI1HcH>; Sat, 28 Sep 2002 03:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262738AbSI1HcH>; Sat, 28 Sep 2002 03:32:07 -0400
Received: from mx2.elte.hu ([157.181.151.9]:44009 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S262737AbSI1HcG>;
	Sat, 28 Sep 2002 03:32:06 -0400
Date: Sat, 28 Sep 2002 09:46:35 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Larry Kessler <kessler@us.ibm.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       "Andrew V. Savochkin" <saw@saw.sw.com.sg>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Richard J Moore <richardj_moore@uk.ibm.com>
Subject: Re: [PATCH-RFC] 4 of 4 - New problem logging macros, SCSI RAIDdevice
  driver
In-Reply-To: <Pine.LNX.4.44.0209262140380.1655-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0209280934540.13549-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 26 Sep 2002, Linus Torvalds wrote:
> On Thu, 26 Sep 2002, Jeff Garzik wrote:
> > Tangent question, is it definitely to be named 2.6?
> 
> I see no real reason to call it 3.0.
> 
> The order-of-magnitude threading improvements might just come closest to
> being a "new thing", but yeah, I still consider it 2.6.x. We don't have
> new architectures or other really fundamental stuff. In many ways the
> jump from 2.2 -> 2.4 was bigger than the 2.4 -> 2.6 thing will be, I
> suspect.

i consider the VM and IO improvements one of the most important things
that happened in the past 5 years - and it's definitely something that
users will notice. Finally we have a top-notch VM and IO subsystem (in
addition to the already world-class networking subsystem) giving
significant improvements both on the desktop and the server - the jump
from 2.4 to 2.5 is much larger than from eg. 2.0 to 2.4.

I think due to these improvements if we dont call the next kernel 3.0 then
probably no Linux kernel in the future will deserve a major number. In 2-4
years we'll only jump to 3.0 because there's no better number available
after 2.8. That i consider to be ... boring :) [while kernel releases are
supposed to be a bit boring, i dont think they should be _that_ boring.]

	Ingo

