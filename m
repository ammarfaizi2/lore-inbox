Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932684AbVITGWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932684AbVITGWH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 02:22:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932699AbVITGWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 02:22:07 -0400
Received: from ice.139.client151.icenet.net ([203.88.139.151]:17311 "HELO
	qmail.india.einfochips.com") by vger.kernel.org with SMTP
	id S932684AbVITGWG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 02:22:06 -0400
Message-ID: <32854.192.168.9.246.1127197320.squirrel@192.168.9.246>
Date: Tue, 20 Sep 2005 11:52:00 +0530 (IST)
Subject: regarding kernel compilation
From: "Gireesh Kumar" <gireesh.kumar@einfochips.com>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'd like to compile 2.4.20-6 kernel while running in 2.6 kernel. I tried
to do so but there are redeclaration errors with /kernel/sched.c and
/include/linux/sched.h. One it is FASTCALL and the other it is not.
Can anyone help me to fix this?
Thankyou,
Gireesh.

