Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbTIISzA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 14:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264306AbTIISzA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 14:55:00 -0400
Received: from mid-1.inet.it ([213.92.5.18]:13748 "EHLO mid-1.inet.it")
	by vger.kernel.org with ESMTP id S264304AbTIISy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 14:54:59 -0400
Message-ID: <003e01c37704$79551720$36af7450@wssupremo>
Reply-To: "Luca Veraldi" <luca.veraldi@katamail.com>
From: "Luca Veraldi" <luca.veraldi@katamail.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Efficient IPC mechanism on Linux
Date: Tue, 9 Sep 2003 20:59:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You're right. When i have a bit of time, i'll translate the page.

The version of the kernel is not so important.
The code is highly portable and little dependent of the internals of kernel.
It only needs some functions that continue to survive in newer versions of
Linux.
I used 2.2.4 only because it was ready-to-use on my machine.

The main purpose of the article was not to present a professional
mechanism that you can download and use into your own applications.

It is only the proof of a fact: Linux IPC Mechanisms
are ***structurally*** inefficient.

Bye.
Luca


