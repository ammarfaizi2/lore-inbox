Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265585AbUEZNqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265585AbUEZNqY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 09:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265685AbUEZNqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 09:46:24 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:27806 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S265585AbUEZNpl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 09:45:41 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'Denis Vlasenko'" <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: <orders@nodivisions.com>, <linux-kernel@vger.kernel.org>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 06:48:45 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <200405261519.45746.vda@port.imtp.ilyichevsk.odessa.ua>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Thread-Index: AcRDHsU2nRg7MoaNRaqTh6GLiwuqoQAB6CIw
Message-Id: <S265585AbUEZNpl/20040526134541Z+588@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I like that, pull out the Hobby OS/small purpose card when it's convenient,
but a lot of the plans I see talked about for the kernel revolve around
features that are needed to support the type of applications that are being
stressed by Corporate America. That's where a significant amount of money
being poured (directly or indirectly) into linux right now, and that is
where the bulk of the next level of challenges in terms of kernel
development are going to come from. 

Linux is already a modern OS in most respects, the next logical programming
challenges are solving some of the vertical scaling issues, even as most of
these applications are moving in a growing trend toward scaling
horizontally.

--Buddy



-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Denis Vlasenko
Sent: Wednesday, May 26, 2004 5:20 AM
To: Buddy Lumpkin
Cc: orders@nodivisions.com; linux-kernel@vger.kernel.org
Subject: RE: why swap at all?

On Wednesday 26 May 2004 15:07, Buddy Lumpkin wrote:
> those environments horizontally in most cases. The biggest performance
> problems to solve (that people care about and are willing to pay $$ to
> solve) are for the large databases that run Corporate America. There are
> certainly scientific applications where performance is critical and there
> are dollars to fund improvement as well, but their numbers don't compare
to
> the number of Oracle instances out there running in the Enterprise.

Oh yeah, poor Corporate America. That what we should care most of.

> Optimizing the performance of swap operations for even a small tradeoff in
> performance for memory operations that take place entirely in physical
> memory is just a broke minded, brain dead direction in the year 2004 IMHO.

Sorry Buddy. I am _not_ Corporate America.
I have 4 boxes at work and 5 boxes at home,
and only one of them can be safely run swapless. It's a router.
--
vda
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

