Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbTIFSAI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 14:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTIFSAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 14:00:08 -0400
Received: from law10-oe32.law10.hotmail.com ([64.4.14.89]:40973 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261471AbTIFSAD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 14:00:03 -0400
X-Originating-IP: [208.48.228.132]
X-Originating-Email: [jyau_kernel_dev@hotmail.com]
From: "John Yau" <jyau_kernel_dev@hotmail.com>
To: "'Robert Love'" <rml@tech9.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] Minor scheduler fix to get rid of skipping in xmms
Date: Sat, 6 Sep 2003 13:59:53 -0400
Message-ID: <000001c374a0$acebf4c0$f40a0a0a@Aria>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <1062867675.3754.0.camel@boobies.awol.org>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-OriginalArrivalTime: 06 Sep 2003 18:00:03.0190 (UTC) FILETIME=[B2535160:01C374A0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm...I just started monitoring the linux-kernel list on an archive website
last week, so I have no idea if my patch is duplicate work.  I can't seem to
find the specific patch you're referring to.  Can you send me a link to the
patch?


John Yau

-----Original Message-----
From: Robert Love [mailto:rml@tech9.net] 
Sent: Saturday, September 06, 2003 1:01 PM
To: John Yau
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Minor scheduler fix to get rid of skipping in xmms


On Sat, 2003-09-06 at 05:46, John Yau wrote:

> I'm new to patch submission process, so bear with me.  This little 
> patch I
> wrote seems to get rid of the annoying skipping in xmms except in the most

> extreme cases.  See comments inlined in code for details of the fix.

This looks exactly like the granular timeslice patch Ingo did?

	Robert Love


