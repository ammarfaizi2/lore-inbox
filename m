Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbTLVHzg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 02:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264341AbTLVHzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 02:55:36 -0500
Received: from chnmfw01.eth.net ([202.9.145.21]:56840 "EHLO ETH.NET")
	by vger.kernel.org with ESMTP id S264340AbTLVHzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 02:55:35 -0500
From: k_nema@eth.net
Reply-to: k_nema@eth.net
To: linux-kernel@vger.kernel.org
Date: Mon, 22 Dec 2003 13:16:37 +0550
Subject: How to read IDE status registers
X-Mailer: DMailWeb Web to Mail Gateway 2.8d, http://netwinsite.com/top_mail.htm
Message-id: <3fe6a15d.1d4.0@eth.net>
X-User-Info: 202.9.130.77
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Dec 2003 07:53:42.0687 (UTC) FILETIME=[B80E5AF0:01C3C860]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
I wanted to read the IDE status registers, as i want to write to disk with
all the interuppts disabled. Please, tell me a way to do this. I was
wondering if i cud make use of the ACPI code, as it too reads the status
registers. But i dont know how exactly it is done.

Also, i wanted to know, how to issue IDE commands directly to the IDE disk.
i cannot find the kernel code where this is done.

thanx,
Kanika
http://www.ddsl.net
