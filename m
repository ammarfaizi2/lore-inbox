Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271653AbTGRAaA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 20:30:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271659AbTGRAaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 20:30:00 -0400
Received: from web60004.mail.yahoo.com ([216.109.116.227]:43891 "HELO
	web60004.mail.yahoo.com") by vger.kernel.org with SMTP
	id S271653AbTGRA37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 20:29:59 -0400
Message-ID: <20030718004454.81385.qmail@web60004.mail.yahoo.com>
Date: Fri, 18 Jul 2003 01:44:54 +0100 (BST)
From: =?iso-8859-1?q?Steven=20Newbury?= <s_j_newbury@yahoo.co.uk>
Subject: Re: [PATCH resend] BadRAM for 2.6.0-test1*
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have come to the conclusion after more testing that there is definately a
major bug in the patch.  It results in many oopses on my system.  However, I
haven't been able to trace it yet.  Could someone please look over the patch
and see if there are any glaring mistakes.

Thanks.


=====
Steve

__________________________________________________
Yahoo! Plus - For a better Internet experience
http://uk.promotions.yahoo.com/yplus/yoffer.html
