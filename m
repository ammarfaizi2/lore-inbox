Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbVKYUjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbVKYUjY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 15:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbVKYUjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 15:39:24 -0500
Received: from [80.84.72.33] ([80.84.72.33]:18860 "EHLO mail3.uklinux.net")
	by vger.kernel.org with ESMTP id S1751480AbVKYUjY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 15:39:24 -0500
Subject: 2.6.14-rt15 tsc_c3_compensate undefined
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>
From: John Rigg <lk@sound-man.co.uk>
Message-Id: <E1EfkTY-00017Q-9K@localhost.localdomain>
Date: Fri, 25 Nov 2005 20:47:20 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo,
I've just compiled 2.6.14-rt15 on x86_64 smp and got the following message
from make modules_install:

WARNING: /lib/modules/2.6.14-rt15/kernel/drivers/acpi/processor.ko \
needs unknown symbol tsc_c3_compensate

John
