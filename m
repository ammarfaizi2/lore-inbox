Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261998AbTD2NYk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 09:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbTD2NYk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 09:24:40 -0400
Received: from mxout3.netvision.net.il ([194.90.9.24]:36290 "EHLO
	mxout3.netvision.net.il") by vger.kernel.org with ESMTP
	id S261998AbTD2NYj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 09:24:39 -0400
Date: Tue, 29 Apr 2003 16:36:41 +0300
From: Nir Livni <nirl@cyber-ark.com>
Subject: ext2 performance
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Message-id: <E1298E981AEAD311A98D0000E89F45134B55D6@ORCA>
MIME-version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
 
Sorry about the previous post (HTML mistakenly).

Where can i find some info about ext2 performance issues ?
 
I would like to know if library functions like stat (not fstat) , and open
(existing or new file) are affected by the number of files that exists in
1. the number of files in the file's directory
2. the number of files in the file system.
 
Are you aware of any improvements in latest kernels ?
 
Please CC me on your answer.
 
Thanks,
Nir
