Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264641AbTE1LAM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 07:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264651AbTE1LAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 07:00:12 -0400
Received: from [202.54.110.230] ([202.54.110.230]:32275 "EHLO
	ngate.noida.hcltech.com") by vger.kernel.org with ESMTP
	id S264641AbTE1LAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 07:00:11 -0400
Message-ID: <E04CF3F88ACBD5119EFE00508BBB2121098709C6@exch-01.noida.hcltech.com>
From: "Hemanshu Kanji Bhadra, Noida" <hemanshub@noida.hcltech.com>
To: linux-kernel@vger.kernel.org
Subject: device drivers
Date: Wed, 28 May 2003 16:35:14 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

is there any difference if i write kernel module device drivers using
proc_fs in /proc and in a traditional way in /dev directory.

I mean from the application point of view is there any difference when
application tries to access the device using the device driver residing in
/proc directory and not in /dev.


With Thanks,
-Hemanshu 
