Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbUCAAXf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Feb 2004 19:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262192AbUCAAXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Feb 2004 19:23:35 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:8382 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262191AbUCAAXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Feb 2004 19:23:34 -0500
From: Bob Johnson <livewire@gentoo.org>
Reply-To: livewire@gentoo.org
To: B.Zolnierkiewicz@pw.edu.pl
Subject: siimage/seagate   2.6.4-rc1 / 2.6.3-mm4
Date: Sun, 29 Feb 2004 19:31:43 -0500
User-Agent: KMail/1.6
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200402291931.43753.livewire@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a siimage controller with a seagate sata drive that requires the errata 
fix. The patch in 2.6.4-rc1 and 2.6.3-mm4 cause a lockup before i can get 
through init.

All recent kernels without the patch work fine using ata drivers, libata locks
also.

		Bob
