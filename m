Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269801AbRHGXGT>; Tue, 7 Aug 2001 19:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270199AbRHGXGJ>; Tue, 7 Aug 2001 19:06:09 -0400
Received: from mail004.mail.bellsouth.net ([205.152.58.24]:35697 "EHLO
	imf04bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S269801AbRHGXGB>; Tue, 7 Aug 2001 19:06:01 -0400
Message-ID: <3B70746B.57C061C5@Bellsouth.net>
Date: Tue, 07 Aug 2001 19:06:19 -0400
From: Josh Wyatt <jdwyatt@Bellsouth.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tim Jansen <tim@tjansen.de>
CC: Mark Atwood <mra@pobox.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
In-Reply-To: <Pine.LNX.4.33.0108071925040.27407-100000@infradead.org> <m3g0b3v8zq.fsf@flash.localdomain> <15UFO2-0nphWSC@fmrl03.sul.t-online.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Jansen wrote:
> 
> On Tuesday 07 August 2001 23:46, Mark Atwood wrote:
> > Userspace init scripts point the finger at kernel, saying "there is no
> > good and no well documented mapping method". Kernel points its finger
> > at userspace, saying "this is the way we do it" and "we cant guarantee
> > a perfect 100% mapping solution, so we're not even going to try for
> > 90%" and "futz with your drivers and modules.conf and init scripts
> > till you get something that works".
> 
> I'm working on one a possible solution, the Device Registry
> (www.tjansen.de/devreg). It solves this problem by assigning device ids to
> physical devices. This allows you to identify a physical device, even after
> you changed tge port.

Sounds interestingly like the solaris solution to the problem,
/etc/path_to_inst.
Thanks,
Josh

