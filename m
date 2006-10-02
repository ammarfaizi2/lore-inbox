Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932714AbWJBHLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932714AbWJBHLQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 03:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbWJBHLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 03:11:16 -0400
Received: from msr16.hinet.net ([168.95.4.116]:5774 "EHLO msr16.hinet.net")
	by vger.kernel.org with ESMTP id S932710AbWJBHLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 03:11:15 -0400
Message-ID: <018401c6e5f1$e76590f0$4964a8c0@icplus.com.tw>
From: "Jesse Huang" <jesse@icplus.com.tw>
To: "Andrew Morton" <akpm@osdl.org>, "Roland Dreier" <rdreier@cisco.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
       <jgarzik@pobox.com>
References: <1159813431.2576.0.camel@localhost.localdomain><20061001235312.aa2c6d17.akpm@osdl.org> <ada3ba7xkvx.fsf@cisco.com>
Subject: Re: [PATCH 1/5] remove TxStartThresh and RxEarlyThresh
Date: Mon, 2 Oct 2006 15:10:55 +0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1807
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1807
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, I had typed wrong word.

It is because patent issue.

Thnaks.
----- Original Message ----- 
From: "Roland Dreier" <rdreier@cisco.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: "Jesse Huang" <jesse@icplus.com.tw>; <linux-kernel@vger.kernel.org>;
<netdev@vger.kernel.org>; <jgarzik@pobox.com>
Sent: Monday, October 02, 2006 3:00 PM
Subject: Re: [PATCH 1/5] remove TxStartThresh and RxEarlyThresh


> > For pattern issue need to remove TxStartThresh and RxEarlyThresh.

 > Please describe this issue more completely.
 >
 > What are the implications of simply removing this feature?  Presumably
that
 > code was there for a reason..

Actually I think this patch needs to be handled delicately -- because
based on earlier emails from Jesse
(http://www.mail-archive.com/netdev@vger.kernel.org/msg22254.html),
I am pretty sure that "pattern" is a typo for "patent".  So I guess
the question is what exactly the patent covers and what the
implications of having the current kernel code are.

 - R.


