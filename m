Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262851AbVBCFMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262851AbVBCFMc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 00:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbVBCFMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 00:12:31 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:42729 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S262537AbVBCFMU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 00:12:20 -0500
Date: Thu, 03 Feb 2005 14:12:22 +0900
From: Itsuro Oda <oda@valinux.co.jp>
To: vgoyal@in.ibm.com
Subject: kdump on non-boot cpu
Cc: fastboot@osdl.org, linux-kernel@vger.kernel.org
Message-Id: <20050203140438.18E1.ODA@valinux.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Mailer: Becky! ver. 2.10.04 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I found the following in an old mail:

>From vgoyal at in.ibm.com  Thu Jan  6 07:20:43 2005
...
>2. Kdump can possibly fail on SMP machines if crash occurs on non-boot
>cpu. Hari is finalizing the stop gap patch to handle this problem.

Is this finished ?  (It seems it is not in 2.6.11-rc2-mm1.)
-- 
Itsuro ODA <oda@valinux.co.jp>

