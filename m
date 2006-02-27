Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751676AbWB0IMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751676AbWB0IMm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:12:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751678AbWB0IMm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:12:42 -0500
Received: from tag.witbe.net ([81.88.96.48]:5821 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S1751675AbWB0IMl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:12:41 -0500
From: "Paul Rolland" <rol@witbe.net>
To: "'Jeff Garzik'" <jgarzik@pobox.com>,
       "'Linus Torvalds'" <torvalds@osdl.org>
Cc: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.16-rc5
Date: Mon, 27 Feb 2006 09:13:09 +0100
Organization: Witbe.net
Message-ID: <006e01c63b75$a51d4890$b600a8c0@cortex>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <4402934B.7040506@pobox.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcY7YdixV2cE5fS0RfKZpRnUR+SbZQAE7XIg
x-ncc-regid: fr.witbe
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Missing also the fix I sent for e1000 MII interface.

Paul

Paul Rolland, rol(at)as2917.net
ex-AS2917 Network administrator and Peering Coordinator

--

Please no HTML, I'm not a browser - Pas d'HTML, je ne suis pas un navigateur 
"Some people dream of success... while others wake up and work hard at it" 

"I worry about my child and the Internet all the time, even though she's too 
young to have logged on yet. Here's what I worry about. I worry that 10 or 15 
years from now, she will come to me and say 'Daddy, where were you when they 
took freedom of the press away from the Internet?'"
--Mike Godwin, Electronic Frontier Foundation 
 
  

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Jeff Garzik
> Sent: Monday, February 27, 2006 6:51 AM
> To: Linus Torvalds
> Cc: Linux Kernel Mailing List
> Subject: Re: Linux v2.6.16-rc5
> 
> Linus Torvalds wrote:
> > The tar-ball is being uploaded right now, and everything 
> else should 
> > already be pushed out. Mirroring might take a while, of course.
> > 
> > There's not much to say about this: people have been pretty 
> good, and it's 
> > just a random collection of fixes in various random areas. 
> The shortlog is 
> > actually pretty short, and it really describes the updates 
> better than 
> > anything else.
> > 
> > Have I missed anything? Holler. And please keep reminding about any 
> > regressions since 2.6.15.
> 
> Yep, you missed the data corruption fix (libata) and oops fix 
> (netdev) 
> that I sent at 5pm EST today...
> 
> And we may have to turn off FUA (barriers) before 2.6.16 goes out.
> 
> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

