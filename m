Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265237AbUD3Tjt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265237AbUD3Tjt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 15:39:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265238AbUD3Tjt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 15:39:49 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:13596 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S265237AbUD3Tii convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 15:38:38 -0400
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Linus Torvalds'" <torvalds@osdl.org>
Cc: "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "'Peter Williams'" <peterw@aurema.com>,
       "'Marc Boucher'" <marc@linuxant.com>,
       "'Sean Estabrooks'" <seanlkml@rogers.com>,
       "'Paul Wagland'" <paul@wagland.net>, "'Rik van Riel'" <riel@redhat.com>,
       "'Timothy Miller'" <miller@techsource.com>, <koke@sindominio.net>,
       "'Rusty Russell'" <rusty@rustcorp.com.au>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'David Gibson'" <david@gibson.dropbear.id.au>
Subject: RE: [PATCH] Blacklist binary-only modules lying about their license
Date: Fri, 30 Apr 2004 12:37:26 -0700
Organization: Cisco Systems
Message-ID: <00b201c42eea$916f6c40$ca41cb3f@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My last email on this topic. If it weren't Linus I would have stopped. :-)

> What is so hard to understand about the problem with bugs?
> 
> All software has bugs. Binary modules just mean that those bugs are
>  - FATAL to the system, including possibly being a huge security hole.
>  - impossible to debug
>  - impossible to fix

It's the user's choice to run binary modules on their systems, as long as
the "tainted" issue is not hidden (which I clearly said was wrong) so the
support burden is directed to the right company/person who will hopefully
fix those bugs, why should it concern kernel developers so much? Let the
user have a choice. A working computer which occasionally crashes is still
better to the user than a stable computer which doesn't do the job.

In this sense, it doesn't matter it's a bug in user space or kernel space,
or hard or easy to fix, as long as it doesn't cause much extra burden to the
community.

All I try to say is about the business model of supporting closed-source
drivers by a GPL'ed wrapper. It may not be perfect in an imperfect world,
but nothing to criticize on.

> So don't bother trying to stand up for Linuxant. What they 
> did was WRONG, and there are no excuses for it. And I hope 
> that they have it fixed already and we can hereby just forget 
> about this discussion.

You don't need to tell me why it was wrong, because I already said it was
wrong. :-) I'm not standing up for linuxant either - I am not their
customers and I hardly heard of this name before. I'm just standing up for a
generic issue (which is often silly).

And I agree we should stop this thread now.

> 		Linus
> 

