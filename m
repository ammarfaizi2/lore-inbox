Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129580AbRBPKhJ>; Fri, 16 Feb 2001 05:37:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130315AbRBPKg7>; Fri, 16 Feb 2001 05:36:59 -0500
Received: from [203.197.249.146] ([203.197.249.146]:28664 "EHLO
	indica.wipsys.stph.net") by vger.kernel.org with ESMTP
	id <S130307AbRBPKgu>; Fri, 16 Feb 2001 05:36:50 -0500
From: "Srinivas Surabhi" <srinivas.surabhi@wipro.com>
To: majordomo@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: driver compilations errors
X-Mailer: Netscape Messenger Express 3.5.2 [Mozilla/4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)]
Date: Fri, 16 Feb 2001 16:10:37 +0530
Message-ID: <77452AAAFC5.AAA234C@vindhya.mail.wipro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


iam getting compilation errors	for driver code.

struct file_operations my_ops ={NULL,my_read,my_write,NULL,NULL,NULL
				NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL
			   NULL };

ERROR -> my_ops has intializer but incomplete type


pls can anybody
help


