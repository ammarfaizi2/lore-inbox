Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265001AbTFTW2r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 18:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265003AbTFTW2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 18:28:47 -0400
Received: from smtp.hotbox.ru ([80.68.244.50]:25349 "EHLO smtp.hotbox.ru")
	by vger.kernel.org with ESMTP id S265001AbTFTW2q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 18:28:46 -0400
Date: Sat, 21 Jun 2003 02:40:48 +0400
From: Nikolai Zhubr <s001@hotbox.ru>
Message-ID: <1321271967.20030621024048@hotbox.ru>
To: linux-kernel@vger.kernel.org
Subject: Debugging lockup - question
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello people,
i appologise if my question is too stupid. I'm trying to debug
experimental kernel module (network stack), running 2.4.20(x86),
and I have encountered sort of lockup/abnormal state. That is,
console doesn't respond to any normal keys or VT-switch, mouse
is unresponsive, network seems unresponsive too, but num-lock
is alive and ctrl-alt-del causes clean shutdown, so the kernel
probably doesn't get damaged but just somehow blocks. What could
this be? Any hints greatly appreciated.
Thank you.
Please CC me, I'm not subscribed.
-- 
Best regards,
 Nikolai Zhubr


