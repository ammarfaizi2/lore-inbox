Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262193AbVA0IKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbVA0IKG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 03:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVA0IKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 03:10:06 -0500
Received: from bay5-f4.bay5.hotmail.com ([65.54.173.4]:6900 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id S262193AbVA0IKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 03:10:02 -0500
Message-ID: <BAY5-F46ADF0245BD35CAC720E9A4780@phx.gbl>
X-Originating-IP: [61.220.240.162]
X-Originating-Email: [ejhsu@msn.com]
From: "Hsu I-Chieh" <ejhsu@msn.com>
To: linux-kernel@vger.kernel.org
Subject: A question about TLB mapping in MIPS
Date: Thu, 27 Jan 2005 08:09:44 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=big5; format=flowed
X-OriginalArrivalTime: 27 Jan 2005 08:10:00.0932 (UTC) FILETIME=[99323240:01C50447]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

In version 2.6.4, I observed that the "global" bit will be set if this tlb 
entry is used to map KSEG2 (kernel segment 2, starting from 0xc0000000). 
But in version 2.6.10, the "global" bit won't be set even if the tlb entry 
is used to map KSEG2.

I would like to know if it's right.

Thanks in advance.

regards,

Jacky

_________________________________________________________________
想戀愛？交朋友？MSN 線上交友：由 Match.com 提供，全世界最受歡迎的線上交友服
務 http://match.msn.com.tw 

