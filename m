Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265988AbTFWKJG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 06:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265986AbTFWKJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 06:09:05 -0400
Received: from msgbas1x.cos.agilent.com ([192.25.240.36]:44270 "EHLO
	msgbas1x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S265988AbTFWKHF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 06:07:05 -0400
content-class: urn:content-classes:message
Subject: Linux-2.5.71 kernel compile error
Date: Fri, 20 Jun 2003 16:05:12 -0600
Message-ID: <334DD5C2ADAB9245B60F213F49C5EBCD05D551C2@axcs03.cos.agilent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Linux-2.5.71 kernel compile error
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Thread-Index: AcM3eA4ys/yavp0iEdeA3wBgsGgWXA==
From: <yiding_wang@agilent.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Team,

I got failure on compiling the kernel in one of SuperMicro signle CPU system.  It has a Linux 2.4.2 on it.  
The message is "Unknown Pseudo-op:  '.incbin'"

The file brings the trouble is arch/i386/kernel/vsyscall.S.

I think it must be a configuration problem but don't know which one is causing the trouble. I am using menuconfig to change the configuration.

Any suggestion?

Thanks!

Eddie 
