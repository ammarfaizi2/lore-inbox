Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282969AbRLMBTh>; Wed, 12 Dec 2001 20:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282981AbRLMBTS>; Wed, 12 Dec 2001 20:19:18 -0500
Received: from pizda.ninka.net ([216.101.162.242]:65415 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282969AbRLMBTP>;
	Wed, 12 Dec 2001 20:19:15 -0500
Date: Wed, 12 Dec 2001 17:18:57 -0800 (PST)
Message-Id: <20011212.171857.116353047.davem@redhat.com>
To: michael@bizsystems.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17-pre8
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200112130113.RAA17715@ns2.bizsystems.net>
In-Reply-To: <200112130113.RAA17715@ns2.bizsystems.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Michael" <michael@bizsystems.com>
   Date: Wed, 12 Dec 2001 17:13:44 -0800

   There still remains an unpatched file in netfilters for 
   iptables-1.2.4
   
   net/ipv4/netfilter/ipt_TOS.c
   
   It would be nice to complete all the patches for netfilter before 
   2.4.17 is released.
   
What patch is missing?  Actually, it is up to the netfilter
maintainers to make sure I am up to date with all necessary
patches that are needed.

I push along everything they send me (after a quick cursory review of
their change of course).

