Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbTF0Wqf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 18:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbTF0Wqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 18:46:34 -0400
Received: from mx2.idealab.com ([64.208.8.4]:30749 "EHLO butch.idealab.com")
	by vger.kernel.org with ESMTP id S264890AbTF0Wqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 18:46:31 -0400
X-Qmail-Scanner-Mail-From: srini@omnilux.net via butch.idealab.com
X-Qmail-Scanner: 1.03 (Clean. Processed in 1.507716 secs)
From: "Srini" <srini@omnilux.net>
To: <linux-kernel@vger.kernel.org>
Subject: Process Termination Indication in the Device Driver
Date: Fri, 27 Jun 2003 16:02:30 -0700
Message-ID: <GOEALIFINNJACMGKPLKLIECNCEAA.srini@omnilux.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I am new to Linux Kernel. I am experimenting with Device Driver in Kernel
version 2.4. Is there a method by which the device driver could be indicated
by the
kernel of the termination of a "user process" asynchronously.

I know of the function find_task_by_pid that the driver could call to get
the task
structure given the pid.

Thanks in Advance

Srini

