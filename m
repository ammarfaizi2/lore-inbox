Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbUCEJOA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 04:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUCEJOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 04:14:00 -0500
Received: from [152.101.81.89] ([152.101.81.89]:3335 "HELO southa.com")
	by vger.kernel.org with SMTP id S262266AbUCEJN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 04:13:59 -0500
Message-ID: <088201c40293$5b27ce80$9c02a8c0@southa.com>
From: "Kyle Wong" <kylewong@southa.com>
To: <linux-kernel@vger.kernel.org>
Subject: questions about io scheduler
Date: Fri, 5 Mar 2004 17:22:17 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1. Is  anticipatory io scheduler + echo 0 >
/sys/block/hd*/queue/iosched/antic_expire = deadline scheduler?

2. Does io scheduler works with md RAID? Correct me if I'm wrong,
io-schedular <-->  md driver <--> harddisks.

Regards,
Kyle

