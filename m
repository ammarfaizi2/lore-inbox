Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbTLJRRb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263667AbTLJRPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:15:38 -0500
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:10680 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S263811AbTLJRPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:15:20 -0500
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Andre Hedrick'" <andre@linux-ide.org>
Cc: "'Arjan van de Ven'" <arjanv@redhat.com>, <Valdis.Kletnieks@vt.edu>,
       "'Kendall Bennett'" <KendallB@scitechsoft.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Linux GPL and binary module exception clause?
Date: Wed, 10 Dec 2003 09:15:15 -0800
Organization: Cisco Systems
Message-ID: <00af01c3bf41$2db12770$d43147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
In-Reply-To: <Pine.LNX.4.58.0312100714390.29676@home.osdl.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The inlines have nothing to do with _anything_.
> 
> Trust me, a federal judge couldn't care less about some very esoteric
> technical detail. I don't know who brought up inline 
> functions, but they aren't what would force the GPL.

Great!

> What has meaning for "derived work" is whether it stands on its own or
> not, and how tightly integrated it is. If something works 
> with just one particular version of the kernel - or depends on things
like 
> whether the kernel was compiled with certain options etc - then it
pretty 
> clearly is very tightly integrated.

Many userspace programs fall into this category too. For example they
depend on /proc to be there. They probably only work with a certain
version of the kernel because the next version changed some format in
/proc.

Is /proc a stable API/ABI? Yes? No?

> Don't think that copyright would depend on any technicalities.
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

