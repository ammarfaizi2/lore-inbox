Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264492AbRFTRJf>; Wed, 20 Jun 2001 13:09:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264495AbRFTRJ0>; Wed, 20 Jun 2001 13:09:26 -0400
Received: from [142.176.139.106] ([142.176.139.106]:5637 "EHLO ve1drg.com")
	by vger.kernel.org with ESMTP id <S264492AbRFTRJL>;
	Wed, 20 Jun 2001 13:09:11 -0400
Date: Wed, 20 Jun 2001 14:09:08 -0300 (ADT)
From: Ted Gervais <ve1drg@ve1drg.com>
To: Luigi Genoni <kernel@Expansa.sns.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: ip_tables/ipchains
In-Reply-To: <Pine.LNX.4.33.0106201518140.9682-100000@Expansa.sns.it>
Message-ID: <Pine.LNX.4.21.0106201408460.3517-100000@ve1drg.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jun 2001, Luigi Genoni wrote:

> Have you also compiled modules for ipchains and ipfwadm support??


Yes.  Is this a mistake??

> 
> 
> On Wed, 20 Jun 2001, Ted Gervais wrote:
> 
> > Wondering something..
> > I ran insmod to bring up ip_tables.o and I received the following error:
> >
> > /lib/modules/2.4.5/kernel/net/ipv4/netfilter/ip_tables.o: unresolved
> > symbol nf_unregister_sockopt
> > /lib/modules/2.4.5/kernel/net/ipv4/netfilter/ip_tables.o: unresolved
> > symbol nf_register_sockopt
> >
> > This is with kernel 2.4.5 and Slackware 7.1 is the distribution.
> > Does anyone know what these unresolved symbols are about??
> >
> > ---
> > Doubt is not a pleasant condition, but certainty is absurd.
> >                 -- Voltaire
> >
> > Ted Gervais <ve1drg@ve1drg.com>
> > 44.135.34.201 linux.ve1drg.ampr.org
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >
> 

---
Doubt is not a pleasant condition, but certainty is absurd.
                -- Voltaire
                
Ted Gervais <ve1drg@ve1drg.com>
44.135.34.201 linux.ve1drg.ampr.org


