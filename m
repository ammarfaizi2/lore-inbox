Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265218AbUD3S7I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265218AbUD3S7I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 14:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264993AbUD3S7I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 14:59:08 -0400
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:34092 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S265219AbUD3S7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 14:59:05 -0400
Reply-To: <hzhong@cisco.com>
From: "Hua Zhong" <hzhong@cisco.com>
To: "'Timothy Miller'" <miller@techsource.com>
Cc: "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "'Peter Williams'" <peterw@aurema.com>,
       "'Marc Boucher'" <marc@linuxant.com>,
       "'Sean Estabrooks'" <seanlkml@rogers.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Paul Wagland'" <paul@wagland.net>, "'Rik van Riel'" <riel@redhat.com>,
       <koke@sindominio.net>, "'Rusty Russell'" <rusty@rustcorp.com.au>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       "'David Gibson'" <david@gibson.dropbear.id.au>
Subject: RE: [PATCH] Blacklist binary-only modules lying about their license
Date: Fri, 30 Apr 2004 11:58:48 -0700
Organization: Cisco Systems
Message-ID: <009e01c42ee5$2e89fc80$ca41cb3f@amer.cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <40929F5B.9090603@techsource.com>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4927.1200
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> WINE is a user process.  It does not run in kernel space, so we don't 
> care about it.  Since all the closed-source stuff, like 
> Office, runs in user space, it CANNOT corrupt the kernel (barring real 
> kernel bugs).
> 
> I think Linus needs to smack you down like he did with that guy who 
> couldn't understand the distinction between firmware and a 
> kernel driver.

I think he doesn't, because he can read what other said. I know what
distinction it is and I've been working on kernel for years since I was
still in school.

I'm not arguing about the taint issue, or any technical issue, as clearly
stated in my last paragraph. I am mearly responding to the questioning to
Linuxant's business model.

> As long as the kernel is protected, we are generally in favor of it.
>
> > Linuxant did a wrong thing by working around the warning 
> > message, but I don't think it's fair to accuse of their business 
> > because they allow binary drivers run on Linux.
> 
> The fact that binary drivers are "evil" does not reflect badly on 
> Linuxant, in my opinion.

It doesn't look like so to me.

