Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280624AbRKYB1b>; Sat, 24 Nov 2001 20:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280627AbRKYB1W>; Sat, 24 Nov 2001 20:27:22 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:24587 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S280624AbRKYB1H>; Sat, 24 Nov 2001 20:27:07 -0500
Content-Type: text/plain; charset=US-ASCII
From: James Davies <james_m_davies@yahoo.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kswapd and system response
Date: Sun, 25 Nov 2001 11:23:12 +1000
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.33.0111241535160.3541-100000@marauder.googgun.com>
In-Reply-To: <Pine.LNX.4.33.0111241535160.3541-100000@marauder.googgun.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011125012714Z280624-17409+16544@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Nov 2001 06:48, Ahmed Masud wrote:
> On Sat, 24 Nov 2001, Peter Jay Salzman wrote:
> > hi there,
> >
> > every so often, my system (2.4.13 smp) gets really sloooooow.   a typical
 <snip>
> > this has been happening with the 2.4.13 kernel every couple of days.
>
> Hello
>
> I have experienced similar behaviour with kswapd/kupdated with 2.4.12 and
> 2.4.13 .  After much struggle, I discovered that the system had become
> slugish and non-responsive because i was using the wrong IDE busmastering
> and DMA drivers (VIA chipset) instead of the correct ones for my
> motherboard (PROMISE chipset). If you are using IDE, then perhaps you have
> something similar and are using the incorrect drivers?
>
> If you are indeed using IDE then suggest that you turn of busmastering all
> together and give it another try.
>
> Ahmed.

	I am having the same problem with 2.4.6. I have the VIA Drivers compiled in,
	which are the correct ones for my chipset. Perhaps it is a problem with the
	VIA Drivers? I havn't tested it with anything else. 
	


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

