Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262112AbVDXEIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262112AbVDXEIh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 00:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVDXEIh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 00:08:37 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:23969 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262112AbVDXEIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 00:08:36 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: linux-kernel@vger.kernel.org, ak@suse.de
Subject: X86_64: 2.6.12-rc3 spontaneous reboot
Date: Sun, 24 Apr 2005 00:08:35 -0400
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504240008.35435.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While running a 32 bit Java program 2.6.12-rc3 rebooted spontaneously leaving 
a corrupt partition table and disk with errors. There was nothing in dmesg 
(no oops/panic) except some -MARK- entries during the reboot.

No such problems with 2.6.11.  Hardware is a laptop - Compaq presario R3240us 
- Athlon64. It runs solid when running 2.6.11.

Parag
