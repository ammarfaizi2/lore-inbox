Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbULTIsY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbULTIsY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 03:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbULTIsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 03:48:23 -0500
Received: from em.njupt.edu.cn ([202.119.230.11]:57743 "HELO njupt.edu.cn")
	by vger.kernel.org with SMTP id S261248AbULTIrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 03:47:47 -0500
Message-ID: <303535658.02371@njupt.edu.cn>
X-WebMAIL-MUA: [10.10.136.115]
From: "Zhenyu Wu" <y030729@njupt.edu.cn>
To: linux-kernel@vger.kernel.org
Date: Mon, 20 Dec 2004 17:40:58 +0800
Reply-To: "Zhenyu Wu" <y030729@njupt.edu.cn>
X-Priority: 3
Subject: About kernel panic!
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Everyone,

I think i have met lots of troubles when i am programming in the kernel, so, i
want to get
some help.

One of my troubles is that, sometimes, the program can work well, but sometimes,
there are
kernel panics. So, does someone else meet such questions, what is the major
reasons? From the
indication of the log messages, i can find the messages on allocting the memory, i
remember, 
i use the kmalloc to do it, but is there something wrong? 

Thanks,


