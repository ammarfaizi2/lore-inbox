Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbUBTUf4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 15:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbUBTUfe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 15:35:34 -0500
Received: from [208.2.222.88] ([208.2.222.88]:52407 "EHLO thor.htshq.com")
	by vger.kernel.org with ESMTP id S261321AbUBTUfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 15:35:09 -0500
Message-ID: <001901c3f7f1$051a6220$10a8a8c0@htshq.com>
From: "Sid Stautzenberger" <sstautzenberger@htshq.com>
To: <linux-kernel@vger.kernel.org>
Subject: Kernels 2.4.21 and Subsequent and Toshiba XM-1702B CDROMs
Date: Fri, 20 Feb 2004 12:35:03 -0800
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
X-Sanitizer: HTS, Inc. Mailwall v1.63
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux-Kernel.Org:

I'm not sure where to ask help for this problem. I have installed and tested
many Linux distros on my Dell Inspiron 3200 which uses a Toshiba XM-1702B
CDROM. I have had no problem with installing any distro from CD iso images.
Now I have discovered that all distros built on kernels 2.4.21 or subsequent
no longer support the Toshiba XM-1702B drive. I've tried reading thru the
kernel source programs and information, and it leads one to believe that
this CDROM is still supported. This can't be the case. Who can I ask for
help getting a fix. I am presently using Slackware based on 2.4.20 and
Xandros based on 2.4.19.
Ditributions based on 2.4.21/22/24 and 2.6.1/2 will attempt to read the
CDROM (/dev/hdc) but after nearly a minute an error will be displayed
indicating dirctory not found. I think the problem is in the ide code in the
kernel source. Exactly where I haven't a clue. I'm stuck not being able to
upgrade to newer kernels.

Sid Stautzenberger

