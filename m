Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266224AbRGSXm7>; Thu, 19 Jul 2001 19:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266263AbRGSXmu>; Thu, 19 Jul 2001 19:42:50 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:4077 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id <S266224AbRGSXmo>; Thu, 19 Jul 2001 19:42:44 -0400
Date: Thu, 19 Jul 2001 18:53:21 -0500
From: Andrew Friedley <saai@swbell.net>
Subject: Re: [PATCH] PPPOE can kfree SKB twice (was Re: kernel panic problem.
 (smp, iptables?))
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <003d01c110ad$fe41db40$0200a8c0@loki>
MIME-version: 1.0
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
Content-type: text/plain; charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-MSMail-Priority: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
In-Reply-To: <005f01c10e69$28273e60$0200a8c0@loki>
 <15189.2408.59953.395204@pizda.ninka.net>
 <sb6r8vcg31q.fsf@slug.watson.ibm.com>
 <15191.27007.837441.266822@pizda.ninka.net>
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hey, I'm having trouble applying your first patch to kernel 2.4.6.  I have a
list of 18 failed hunks.
The command I used is: cd /usr/src/linux && patch -Np0 -i
/home/arch/pppoe-davidmiller.patch  Is the patch for a different kernel? I
had the same problem applying it to 2.4.7-pre8.

Andrew Friedley


> Michal Ostrowski writes:
>  > Alexey replied to my last post with some valuable comments and in
>  > response I have a new patch (that goes on top of David Miller's patch
>  > from yesterday).
>
> Applied to my tree, thanks.
>
> Later,
> David S. Miller
> davem@redhat.com


