Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbUKCMQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbUKCMQG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 07:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbUKCMQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 07:16:05 -0500
Received: from zone3.gcu-squad.org ([217.19.50.74]:16145 "EHLO
	zone3.gcu-squad.org") by vger.kernel.org with ESMTP id S261571AbUKCMQC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 07:16:02 -0500
Date: Wed, 3 Nov 2004 13:10:14 +0100 (CET)
To: linux-kernel@vger.kernel.org
Subject: dmi_scan on x86_64
X-IlohaMail-Blah: khali@gcu.info
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.13 (On: webmail.gcu.info)
Message-ID: <b4V55sKZ.1099483813.4024460.khali@gcu.info>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
CC: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

Any reason why dmi_scan is availble on the i386 arch and not on the
x86_64 arch? I would have a need for the latter (for run-time
identification purposes, not boot-time blacklisting).

Thanks,
Jean Delvare
