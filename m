Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265510AbUGZTsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUGZTsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 15:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265981AbUGZTsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 15:48:32 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:37382 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265510AbUGZSwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 14:52:18 -0400
Message-ID: <41055962.1050002@techsource.com>
Date: Mon, 26 Jul 2004 15:20:02 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Thinking about Linux 4.0...
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"4.0, you say?"  Well, the idea is to get people thinking about things 
which otherwise they might not suggest because they're just too outlandish.

With the embracing of this new development model, we will speed up Linux 
microevolution.  New features which are consistent with the philosophy 
of 2.6 will be accepted more readily.  But there will now be some added 
resistance against, shall we say, punctuations in the equillibrium. 
That is, revolutionary new ideas which break things or affect the 
philosophy of the kernel in a very fundamental way will be shunned.  The 
reason this is a problem is because, I expect, 2.6 will live longer as 
the bleeding edge than those that came before.

It might be interesting to see people discuss advances to the Linux 
kernel which, if interesting enough, would force a meaningful push into 
2.7.  And also interesting would be discussion of ideas that would be 
good for the kernel to have but which are too radical for 2.6.

Also, if you have an idea in reserve which you think would not work for 
2.6, you might be wrong.  It might be that some radical ideas could be 
made to fit.


Here's an example (probably a bad one):  Lots of discussion has been 
going on about reducing latency.  Many of the ideas just patch over the 
latencies, rather than, say, making it impossible to have latency 
problems.  Is there room in the future of Linux to have a driver model 
which is much more real-time in nature?

