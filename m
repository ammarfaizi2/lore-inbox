Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262050AbUFXFl1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbUFXFl1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 01:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbUFXFl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 01:41:27 -0400
Received: from [210.22.146.172] ([210.22.146.172]:49877 "EHLO
	asbmx.sbell.com.cn") by vger.kernel.org with ESMTP id S262050AbUFXFl0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 01:41:26 -0400
content-class: urn:content-classes:message
Subject: RE: Which factors affect linux context switch time?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Date: Thu, 24 Jun 2004 13:40:51 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
Message-ID: <8519CCCD09C9FD409F4CF310566CB4D2010BFD87@sdcmail.sbell.com.cn>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Which factors affect linux context switch time?
Thread-Index: AcRZqo51QA9u3ebFTPGky0jAIatijwAAtqNQ
From: "MCG LU Fengcheng" <Fengcheng.LU@alcatel-sbell.com.cn>
To: "Jeff Woods" <Kazrak+kernel@cesmail.net>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Jun 2004 05:40:52.0227 (UTC) FILETIME=[CFB66D30:01C459AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much!
May you tell me How process code segment size, process data segment size and process RSS affect the context switch time?
(Swap is disabled)

-----Original Message-----
From: Jeff Woods [mailto:Kazrak+kernel@cesmail.net]
Sent: Thursday, June 24, 2004 1:01 PM
To: MCG LU Fengcheng
Subject: Re: Which factors affect linux context switch time?


At 6/24/2004 11:37 AM +0800, you asked:
>Which factors affect Linux context switch time?

>kernel Scheduler, cpu cache, process code segment size, process data 
>segment size, process RSS, or other?

All of the above.

--
Jeff Woods <kazrak+kernel@cesmail.net> 


