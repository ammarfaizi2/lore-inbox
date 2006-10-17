Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422747AbWJQJQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422747AbWJQJQX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 05:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422849AbWJQJQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 05:16:23 -0400
Received: from mail.exanet.com ([212.143.73.109]:63192 "EHLO mr.exanet.com")
	by vger.kernel.org with ESMTP id S1422747AbWJQJQW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 05:16:22 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="windows-1255"
Content-Transfer-Encoding: 8BIT
Subject: epoll AIO in kernel 2.6
Date: Tue, 17 Oct 2006 11:16:20 +0200
Message-ID: <A6FDE6B975803043804A49F12F49028E0F540C@hawk.exanet-il.co.il>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: epoll AIO in kernel 2.6
Thread-Index: AcbxzOiXnj+7CthyTra93qqaLwDxdA==
From: "Menny Hamburger" <menny@exanet.com>
To: "Linux kernel (E-mail)" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Are there any plans to merge the epoll AIO patch into the mainline 2.6?
If not, can you please suggest other alternatives if I need network events to appear on my AIO queue.

Thanks,
Menny
