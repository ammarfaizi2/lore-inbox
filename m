Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263772AbUFXDiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbUFXDiM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 23:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbUFXDiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 23:38:12 -0400
Received: from [210.22.146.172] ([210.22.146.172]:64175 "EHLO
	asbmx.sbell.com.cn") by vger.kernel.org with ESMTP id S263772AbUFXDiL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 23:38:11 -0400
content-class: urn:content-classes:message
Subject: Which factors affect linux context switch time?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Thu, 24 Jun 2004 11:37:55 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
Message-ID: <8519CCCD09C9FD409F4CF310566CB4D2010BFC8F@sdcmail.sbell.com.cn>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Which factors affect linux context switch time?
Thread-Index: AcRZnKuQtTMC+VHrQjOo+TT2y/2fIg==
From: "MCG LU Fengcheng" <Fengcheng.LU@alcatel-sbell.com.cn>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Jun 2004 03:37:56.0289 (UTC) FILETIME=[A34F9B10:01C4599C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel Scheduler, cpu cache, process code segment size, process data
segment size, process RSS, or other?

thx!
