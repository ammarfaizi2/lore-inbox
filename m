Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266805AbUITQ2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266805AbUITQ2f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 12:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266807AbUITQ2f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 12:28:35 -0400
Received: from [81.23.229.73] ([81.23.229.73]:12417 "EHLO mail.eduonline.nl")
	by vger.kernel.org with ESMTP id S266805AbUITQ2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 12:28:30 -0400
From: Norbert van Nobelen <Norbert@edusupport.nl>
Organization: EduSupport
To: linux-kernel@vger.kernel.org
Subject: Machine crashes after disk failure and use of software raid options with 2.4.18 kernel
Date: Mon, 20 Sep 2004 18:28:29 +0200
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409201828.29539.Norbert@edusupport.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of my machines just crashed while it should not do that at disk failure. 
Can someone hint me if the data is still intact before I start with the 
recover?

The disks (4) are configured in raid5 configuration using software raid only. 
Disk setup:
Per disk: 1 GB system, 1 GB swap, 70GB raid space
Only one system disk (I think that is exactly the disk which gave up, so the 
machine won't boot), installed on it: Suse 8.2 professional, standard kernel 
without changes to it.
I don't have any further information than this :-(
