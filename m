Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262816AbUJ1H5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262816AbUJ1H5x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 03:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbUJ1H5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 03:57:53 -0400
Received: from [213.188.213.77] ([213.188.213.77]:17304 "EHLO
	server1.navynet.it") by vger.kernel.org with ESMTP id S262816AbUJ1H5p
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 03:57:45 -0400
From: "Massimo Cetra" <mcetra@navynet.it>
To: <michael@optusnet.com.au>, "'John Richard Moser'" <nigelenki@comcast.net>
Cc: "'Marcos D. Marado Torres'" <marado@student.dei.uc.pt>,
       "'Ed Tomlinson'" <edt@aei.ca>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: My thoughts on the "new development model"
Date: Thu, 28 Oct 2004 09:57:34 +0200
Message-ID: <004601c4bcc3$ca7eaac0$e60a0a0a@guendalin>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <m1sm7znxul.fsf@mo.optusnet.com.au>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There seems to be a lot of strange notions on this concept of 
> 'stable'. The only thing that makes a kernel 'stable' is 
> time. Not endless bugfixes. Just time. The idea of stable 
> software is software that not going to give you any suprises, 
> software that you can trust.
> 
> That's NOT the same as bug free software. For a start, 
> there's no such thing. For another, many bugs are perfectly 
> acceptable in a production environment as long as they're not 
> impacting. (The linux kernel is a very large piece of work. 
> Few installations would use even 20% of the total kernel 
> functionality).
> 

Yes, perfectly right.
You would agree (for example) that this: 

> On Wed, 27 Oct 2004, Danny Brow wrote:
>
> Ok, thank you for the feedback, glad you fixed your problem. 
> Now I guess we just need for someone to find out why 
> LEGACY_PTYS breaks 
> ssh (and other apps?) with kernels >= 2.6.9, but I'm afraid 
> thats beyond 

Does not reflect the behaviour of a stable kernel.
Yes, of course, there's the workaround. But I don't think this bug is
not impacting.

I repeat once again. To me something is going in the wrong direction.

Massimo






