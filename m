Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269759AbUJALSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269759AbUJALSE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 07:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269761AbUJALSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 07:18:04 -0400
Received: from [61.17.31.10] ([61.17.31.10]:9147 "HELO mail.kongu.edu")
	by vger.kernel.org with SMTP id S269759AbUJALRp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 07:17:45 -0400
Message-ID: <49219.172.16.42.200.1096629426.kourier@172.16.42.200>
Date: Fri, 1 Oct 2004 16:47:06 +0530 (IST)
Subject: OS Virtualization
From: "Arvind Kalyan" <arvy@cse.kongu.edu>
To: linux-kernel@vger.kernel.org
User-Agent: Kourier/1.0
X-Mailer: Kourier/1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm trying to load and run two linux kernels simultaneously; trying to
demonstrate virtualization as a first step.


Anyone have pointers to where I can start? I looked into plex, bochs,
vmware, usermode linux.. they only simulate an architecture upon which
another kernel runs.

My intentions are to give control to both the kernels to directly control
the hardware and do "context switch" between those two based on
time-slice.

Thanks in advance.

-- 
i=0141;do{putchar(i);i=i&1?(0x10|i&0xf0)|(i&0xf)<<1:i&4?0:i|4;}while(i);

