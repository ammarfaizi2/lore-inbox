Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264069AbTKJTMl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 14:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264072AbTKJTMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 14:12:41 -0500
Received: from sea2-dav56.sea2.hotmail.com ([207.68.164.191]:12045 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264069AbTKJTMk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 14:12:40 -0500
X-Originating-IP: [12.145.34.101]
X-Originating-Email: [san_madhav@hotmail.com]
From: "sankar" <san_madhav@hotmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: pthread condition variables question
Date: Mon, 10 Nov 2003 11:07:33 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Message-ID: <Sea2-DAV56Ur5qWn3GC00013e02@hotmail.com>
X-OriginalArrivalTime: 10 Nov 2003 19:12:39.0621 (UTC) FILETIME=[9BCFAF50:01C3A7BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
How is pthread condition variables implemented on linux. Specifically I want
to know how pthread_cond_signal() wakes the waiting thread. Does it send any
specific signal to the waiting thread or is there any other means??

Thx in advance.

Sankarshana M
