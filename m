Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274280AbRISXnK>; Wed, 19 Sep 2001 19:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274277AbRISXm7>; Wed, 19 Sep 2001 19:42:59 -0400
Received: from [24.254.60.23] ([24.254.60.23]:33947 "EHLO
	femail33.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S274273AbRISXmj>; Wed, 19 Sep 2001 19:42:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Roberto Jung Drebes <drebes@inf.ufrgs.br>, linux-kernel@vger.kernel.org
Subject: Re: Re[2]: [PATCH] VIA bug stomper. Pls apply.
Date: Wed, 19 Sep 2001 16:41:23 -0700
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.GSO.4.21.0109192003270.1374-100000@jacui>
In-Reply-To: <Pine.GSO.4.21.0109192003270.1374-100000@jacui>
MIME-Version: 1.0
Message-Id: <01091916412300.00579@c779218-a>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 September 2001 04:04 pm, Roberto Jung Drebes wrote:
> On Wed, 19 Sep 2001, Aaron Tiensivu wrote:
> > > I've been busy working on other things, and being ill. I've not yet
> >
> > pursued
> >
> > > it with them
> >
> > A minor nit I have with the patch is that it printk's out "Stomping
> > the Athlon bug", which in actuality is more likely a VIA bug because
> > the symptoms don't show up in other Althon based chipsets..
>
> Anyone tried changing the CPU of a oopsing system to check if it's the
> CPU or the mobo? I have no other athlon/duron or motherboard to try
> here.

I had a SINGLE report of different CPU's doing different things, but 
*most* people aren't swapping different chips into the same motherboard 
very often, so all the people without the problem might have the problem 
when they put in a different CPU, and those with the problem might have 
it go away if they put in a different CPU. I can only assume that this 
BIOS bug is only triggered under certain conditions of the CPU.
