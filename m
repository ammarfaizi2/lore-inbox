Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264874AbRFTNTB>; Wed, 20 Jun 2001 09:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbRFTNSw>; Wed, 20 Jun 2001 09:18:52 -0400
Received: from Expansa.sns.it ([192.167.206.189]:65040 "EHLO Expansa.sns.it")
	by vger.kernel.org with ESMTP id <S264874AbRFTNSs>;
	Wed, 20 Jun 2001 09:18:48 -0400
Date: Wed, 20 Jun 2001 15:18:37 +0200 (CEST)
From: Luigi Genoni <kernel@Expansa.sns.it>
To: Ted Gervais <ve1drg@ve1drg.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ip_tables/ipchains
In-Reply-To: <Pine.LNX.4.21.0106200804160.2944-100000@ve1drg.com>
Message-ID: <Pine.LNX.4.33.0106201518140.9682-100000@Expansa.sns.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Have you also compiled modules for ipchains and ipfwadm support??


On Wed, 20 Jun 2001, Ted Gervais wrote:

> Wondering something..
> I ran insmod to bring up ip_tables.o and I received the following error:
>
> /lib/modules/2.4.5/kernel/net/ipv4/netfilter/ip_tables.o: unresolved
> symbol nf_unregister_sockopt
> /lib/modules/2.4.5/kernel/net/ipv4/netfilter/ip_tables.o: unresolved
> symbol nf_register_sockopt
>
> This is with kernel 2.4.5 and Slackware 7.1 is the distribution.
> Does anyone know what these unresolved symbols are about??
>
> ---
> Doubt is not a pleasant condition, but certainty is absurd.
>                 -- Voltaire
>
> Ted Gervais <ve1drg@ve1drg.com>
> 44.135.34.201 linux.ve1drg.ampr.org
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

