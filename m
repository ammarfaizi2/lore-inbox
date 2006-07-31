Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWGaFYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWGaFYv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 01:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbWGaFYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 01:24:50 -0400
Received: from mail.gmx.net ([213.165.64.21]:49321 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751087AbWGaFYu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 01:24:50 -0400
X-Authenticated: #14349625
Subject: class_device_create_uevent/class_device_create_release log spamage
From: Mike Galbraith <efault@gmx.de>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44BE5A07.9050706@gmx.net>
References: <44BE5A07.9050706@gmx.net>
Content-Type: text/plain
Date: Mon, 31 Jul 2006 07:31:29 +0200
Message-Id: <1154323889.6235.12.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Presumably, these messages were added to find out who is using these.

root@Homer:..tmp/linux-2.6.18-rc3: dmesg|grep 'called for'|uniq -u|wc -l
1265

SuSE 10.1 uses heavily enough that I guess I'm going to have to increase
log buffer size to 18 be able to see a full message set after boot.

	-Mike

