Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287858AbSCOJ0T>; Fri, 15 Mar 2002 04:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287862AbSCOJ0J>; Fri, 15 Mar 2002 04:26:09 -0500
Received: from ip68-7-112-74.sd.sd.cox.net ([68.7.112.74]:2570 "EHLO
	clpanic.kennet.coplanar.net") by vger.kernel.org with ESMTP
	id <S287858AbSCOJZs>; Fri, 15 Mar 2002 04:25:48 -0500
Message-ID: <016401c1cc02$aa51c110$7e0aa8c0@bridge>
From: "Jeremy Jackson" <jerj@coplanar.net>
To: "Dan Maas" <dmaas@dcine.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20020315013644.A26891@morpheus>
Subject: Re: unwanted disk access by the kernel?
Date: Fri, 15 Mar 2002 01:20:32 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You may also want to mount your (root) filesystem(s) with the
"noatime" option... check the linux laptops site for other tips.

----- Original Message ----- 
From: "Dan Maas" <dmaas@dcine.com>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, March 14, 2002 10:36 PM
Subject: unwanted disk access by the kernel?


> I've been trying to set up my laptop for mobile use. I'm having a
> problem with unwanted disk activity - even when the system is
> completely idle, there is still an occasional trickle of disk writes
-SNIP-
