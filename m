Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264613AbRFTUTj>; Wed, 20 Jun 2001 16:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264623AbRFTUTT>; Wed, 20 Jun 2001 16:19:19 -0400
Received: from f117.law9.hotmail.com ([64.4.9.117]:26630 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S264613AbRFTUTO>;
	Wed, 20 Jun 2001 16:19:14 -0400
X-Originating-IP: [212.58.172.195]
From: "Jonathan Brugge" <jonathan_brugge@hotmail.com>
To: ve1drg@ve1drg.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: ip_tables/ipchains
Date: Wed, 20 Jun 2001 22:19:04 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F11752WVSMuwzR8b47C0000859e@hotmail.com>
X-OriginalArrivalTime: 20 Jun 2001 20:19:05.0118 (UTC) FILETIME=[40BA83E0:01C0F9C6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > On Wed, 20 Jun 2001, Ted Gervais wrote:
> >
> > > Wondering something..
> > > I ran insmod to bring up ip_tables.o and I received the following 
>error:
> > >
> > > /lib/modules/2.4.5/kernel/net/ipv4/netfilter/ip_tables.o: unresolved
> > > symbol nf_unregister_sockopt
> > > /lib/modules/2.4.5/kernel/net/ipv4/netfilter/ip_tables.o: unresolved
> > > symbol nf_register_sockopt
> > >
> > > This is with kernel 2.4.5 and Slackware 7.1 is the distribution.
> > > Does anyone know what these unresolved symbols are about??

What if you do a modprobe ip_tables instead?

_________________________________________________________________________
Get Your Private, Free E-mail from MSN Hotmail at http://www.hotmail.com.

