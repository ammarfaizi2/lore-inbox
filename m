Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275078AbTHGF4u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 01:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275080AbTHGF4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 01:56:50 -0400
Received: from core.kaist.ac.kr ([143.248.147.118]:26305 "EHLO
	core.kaist.ac.kr") by vger.kernel.org with ESMTP id S275078AbTHGF4u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 01:56:50 -0400
Message-ID: <008c01c35ca8$1aaecbb0$a5a5f88f@core8fyzomwjks>
From: "Cho, joon-woo" <jwc@core.kaist.ac.kr>
To: <linux-kernel@vger.kernel.org>
Subject: [Q] How does kernel manage PCI device' memory?
Date: Thu, 7 Aug 2003 14:52:36 +0900
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some deivce attached to PCI slot has memory.

So I am curious about how kernel manage that memory.

Does that memory managed as page and virtual address like normal memory

on host computer? Or some other method?

Please tell me answer or realated documents.

Thanks.


