Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbUCIN0a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 08:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261913AbUCIN0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 08:26:30 -0500
Received: from hoemail1.lucent.com ([192.11.226.161]:43506 "EHLO
	hoemail1.firewall.lucent.com") by vger.kernel.org with ESMTP
	id S261912AbUCIN03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 08:26:29 -0500
Message-ID: <6733C768256DEC42A72BAFEFA9CF06D208FF28BB@II0015EXCH002U>
From: "Karpurapu, Suresh (Suresh)** CTR **" <sureshk@lucent.com>
To: "'rml@tech9.net'" <rml@tech9.net>
Subject: preempt-kernel-rml +  low-latency patches  Query
Date: Tue, 9 Mar 2004 18:56:17 +0530 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,

 is it advisable to apply both preempt-kernel-rml and low-latency patches
for 2.4.18 kernel.
for 2.4.18 kernel I applied the following patches .
1. 2.4.18-pre9-low-latency.patch
2. preempt-kernel-rml-2.4.18-5.patch

After booting Linux with the above patches if I load ATM driver the kernel
is panic
and it is showing in sched.c line 580 . Is there any other patch I have to
apply  or any 
sequence  i.e. first low latency and then preempt kernel or vise versa ..

Thanks and Regards
Suresh K

