Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269653AbUIRXMj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269653AbUIRXMj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 19:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269666AbUIRXMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 19:12:39 -0400
Received: from dialup-4.246.105.195.Dial1.SanJose1.Level3.net ([4.246.105.195]:33408
	"EHLO nofear.bounceme.net") by vger.kernel.org with ESMTP
	id S269653AbUIRXMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 19:12:37 -0400
Reply-To: <syphir@syphir.sytes.net>
From: "C.Y.M." <syphir@syphir.sytes.net>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6.9-rc2-bk4 Unknown symbol __VMALLOC_RESERVE
Date: Sat, 18 Sep 2004 16:12:31 -0700
Organization: CooLNeT
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA9mKu6AlYok2efOpJ3sb3O+KAAAAQAAAAvNyRn41Uu0yDWG5tHRPqegEAAAAA@syphir.sytes.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcSd1Plr/PnGUJEzR8iRlCNHTBJRXQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

After testing 2.6.9-rc2-bk4 today, I am getting the following error when I
attempt to load my Nvidia module:

Sep 18 15:31:36 poseidon kernel: nvidia: module license 'NVIDIA' taints
kernel.
Sep 18 15:31:36 poseidon kernel: nvidia: Unknown symbol __VMALLOC_RESERVE

