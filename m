Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263476AbRFTVSj>; Wed, 20 Jun 2001 17:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262633AbRFTVS2>; Wed, 20 Jun 2001 17:18:28 -0400
Received: from [142.176.139.106] ([142.176.139.106]:31493 "EHLO ve1drg.com")
	by vger.kernel.org with ESMTP id <S262660AbRFTVSK>;
	Wed, 20 Jun 2001 17:18:10 -0400
Date: Wed, 20 Jun 2001 18:18:06 -0300 (ADT)
From: Ted Gervais <ve1drg@ve1drg.com>
To: Jonathan Brugge <jonathan_brugge@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ip_tables/ipchains
In-Reply-To: <F11752WVSMuwzR8b47C0000859e@hotmail.com>
Message-ID: <Pine.LNX.4.21.0106201817150.4220-100000@ve1drg.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2001, Jonathan Brugge wrote:

> > > > Wondering something..
> > > > I ran insmod to bring up ip_tables.o and I received the following 
> >error:
> > > >
> > > > /lib/modules/2.4.5/kernel/net/ipv4/netfilter/ip_tables.o: unresolved
> > > > symbol nf_unregister_sockopt
> > > > /lib/modules/2.4.5/kernel/net/ipv4/netfilter/ip_tables.o: unresolved
> > > > symbol nf_register_sockopt
> > > >
> > > > This is with kernel 2.4.5 and Slackware 7.1 is the distribution.
> > > > Does anyone know what these unresolved symbols are about??
> 
> What if you do a modprobe ip_tables instead?



I did. Sorry about saying ip_tables.o.  I meant just ip_tables..

---
Doubt is not a pleasant condition, but certainty is absurd.
                -- Voltaire
                
Ted Gervais <ve1drg@ve1drg.com>
44.135.34.201 linux.ve1drg.ampr.org


