Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVCQSGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVCQSGd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 13:06:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVCQSGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 13:06:33 -0500
Received: from bay101-f38.bay101.hotmail.com ([64.4.56.48]:59901 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261978AbVCQSGb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 13:06:31 -0500
Message-ID: <BAY101-F3858D9AE9F3222CAB9AB3CC1490@phx.gbl>
X-Originating-IP: [64.4.56.200]
X-Originating-Email: [peter_w_morreale@hotmail.com]
From: "Peter W. Morreale" <peter_w_morreale@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel memory limits?
Date: Thu, 17 Mar 2005 11:06:19 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 17 Mar 2005 18:06:19.0751 (UTC) FILETIME=[05467770:01C52B1C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(I did not see this addressed in the FAQs...)

How much physical memory can the 2.4.26 kernel address in kernel context on 
x86?

What about DMA memory?

Local rumor says ~1GB.  But this makes little sense given a 32-bit address.

Where in the source can I learn more about this?

Thanks,
-PWM


