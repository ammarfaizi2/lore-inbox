Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263475AbUEGKaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUEGKaq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 06:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263529AbUEGKaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 06:30:46 -0400
Received: from [61.135.132.139] ([61.135.132.139]:18190 "EHLO
	websmtp02.sohu.com") by vger.kernel.org with ESMTP id S263475AbUEGKap
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 06:30:45 -0400
Message-ID: <5021040.1083925834604.JavaMail.postfix@mx0.mail.sohu.com>
Date: Fri, 7 May 2004 18:30:34 +0800 (CST)
From: <dongzai007@sohu.com>
To: <linux-kernel@vger.kernel.org>
Subject: usb_driver
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Sohu Web Mail 2.0.13
X-SHIP: 61.49.99.142
X-Priority: 3
X-SHMOBILE: 0
X-SHBIND: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am developing a usb device driver in linux 2.4.

I have a foolish question, how can linux system differentiate usb drivers according to PID&VID.

And, I use "devfs_register(...)" to register a device node in "/dev", it seems that there is no effects, no new files created in "/dev" . Could somebody give me some examples.

THANK YOU.
