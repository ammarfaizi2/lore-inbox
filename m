Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261484AbVB0TfR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261484AbVB0TfR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 14:35:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVB0TfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 14:35:16 -0500
Received: from mxsf18.cluster1.charter.net ([209.225.28.218]:65460 "EHLO
	mxsf18.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S261484AbVB0TfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 14:35:00 -0500
Message-Id: <3rr04b$iv134s@mxip02a.cluster1.charter.net>
X-Ironport-AV: i="3.90,120,1107752400"; 
   d="scan'208"; a="636521628:sNHT13837860"
From: "Laurence Oberman" <zaurus@photonlinux.com>
To: <linux-kernel@vger.kernel.org>
Subject: Figured out the wait queue question
Date: Sun, 27 Feb 2005 14:34:50 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcUdA2deeYkWhmiHQiiiZiPpRB8lYw==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I figured out the answer to my previous question.

I used the equivalent of the list_entry MACRO to get the values
>From the crash dump.

Thanks

Laurence


