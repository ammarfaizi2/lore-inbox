Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263034AbRFTLGH>; Wed, 20 Jun 2001 07:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263675AbRFTLFr>; Wed, 20 Jun 2001 07:05:47 -0400
Received: from [142.176.139.106] ([142.176.139.106]:44036 "EHLO ve1drg.com")
	by vger.kernel.org with ESMTP id <S263034AbRFTLFm>;
	Wed, 20 Jun 2001 07:05:42 -0400
Date: Wed, 20 Jun 2001 08:05:41 -0300 (ADT)
From: Ted Gervais <ve1drg@ve1drg.com>
To: linux-kernel@vger.kernel.org
Subject: ip_tables/ipchains
Message-ID: <Pine.LNX.4.21.0106200804160.2944-100000@ve1drg.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wondering something..
I ran insmod to bring up ip_tables.o and I received the following error:

/lib/modules/2.4.5/kernel/net/ipv4/netfilter/ip_tables.o: unresolved
symbol nf_unregister_sockopt
/lib/modules/2.4.5/kernel/net/ipv4/netfilter/ip_tables.o: unresolved
symbol nf_register_sockopt

This is with kernel 2.4.5 and Slackware 7.1 is the distribution.
Does anyone know what these unresolved symbols are about??

---
Doubt is not a pleasant condition, but certainty is absurd.
                -- Voltaire
                
Ted Gervais <ve1drg@ve1drg.com>
44.135.34.201 linux.ve1drg.ampr.org


