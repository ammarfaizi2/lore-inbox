Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268557AbUHLNd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268557AbUHLNd1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 09:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268559AbUHLNd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 09:33:27 -0400
Received: from mailhost.cs.auc.dk ([130.225.194.6]:26098 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S268557AbUHLNdZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 09:33:25 -0400
Subject: Re: Memory Stick Pro driver
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1092315960.13824.97.camel@rade7.e.cs.auc.dk>
References: <1092312640.13824.89.camel@rade7.e.cs.auc.dk>
	 <yw1xu0v8cyw0.fsf@kth.se>  <1092315367.13824.95.camel@rade7.e.cs.auc.dk>
	 <1092315960.13824.97.camel@rade7.e.cs.auc.dk>
Content-Type: text/plain; charset=ISO-8859-15
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1092317583.13824.114.camel@rade7.e.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 Aug 2004 15:33:06 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

After some small investigation, it seems that:

« Some products in some categories (PC, PDA) will be able to accept
Memory Stick PRO media by upgrading firmware or software. (Available
advantage is high capacity only.) »

Read at the bottom of this page:
http://www.memorystick.com/en/ms/features2.html

Moreover, on this page:
http://ciscdb.sel.sony.com/perl/news-display.pl?news_id=15

I can see that Vaio laptop similar to mine (C1MW and C1MWP) can be
upgraded to read Memory stick Pro...

So, I guess that it is possible. But why is the Linux driver refusing it
?

I'll try this out.

PS: Who is the maintainer of the Memory Stick driver ?

Regards
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.auc.dk

