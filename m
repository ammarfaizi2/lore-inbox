Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275486AbTHMUXe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 16:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275487AbTHMUXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 16:23:32 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:20651 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S275486AbTHMUXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 16:23:24 -0400
Date: Wed, 13 Aug 2003 16:23:17 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200308132023.h7DKNH508763@devserv.devel.redhat.com>
To: Tom Vier <tmv@comcast.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test3: sparc64: no asm/serial.h
In-Reply-To: <mailman.1060747924.1184.linux-kernel2news@redhat.com>
References: <mailman.1060747924.1184.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/serial/8250.c:106:24: asm/serial.h: No such file or directory

Well, duh. Use sunsu for now.

How did you manage to enable it, anyway? And why?

If you want to fix it, I accept patches.

-- Pete
