Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264226AbUFXKmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbUFXKmQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 06:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUFXKmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 06:42:09 -0400
Received: from [210.22.146.172] ([210.22.146.172]:53948 "EHLO
	asbmx.sbell.com.cn") by vger.kernel.org with ESMTP id S264226AbUFXKlj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 06:41:39 -0400
content-class: urn:content-classes:message
Subject: How to develop some codes that pollute the CPU cache?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Thu, 24 Jun 2004 18:41:29 +0800
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
Message-ID: <8519CCCD09C9FD409F4CF310566CB4D2010C0021@sdcmail.sbell.com.cn>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to develop some codes that pollute the CPU cache?
Thread-Index: AcRZ19sTTEiZCa6JSs+Mz32zimlrqQ==
From: "MCG LU Fengcheng" <Fengcheng.LU@alcatel-sbell.com.cn>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 24 Jun 2004 10:41:30.0114 (UTC) FILETIME=[CF218E20:01C459D7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make cpu cache hit rate is 0:)
