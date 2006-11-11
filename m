Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947324AbWKKXAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947324AbWKKXAd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 18:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754898AbWKKXAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 18:00:33 -0500
Received: from build.arklinux.osuosl.org ([140.211.166.26]:9165 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S1754896AbWKKXAd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 18:00:33 -0500
From: Bernhard Rosenkraenzer <bero@arklinux.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.19-rc5-mm1 fails to compile with gcc 4.2
Date: Sat, 11 Nov 2006 23:34:28 +0100
User-Agent: KMail/1.9.5
Cc: akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611112334.28889.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/kvm/kvm_main.c: In function 'kvm_dev_ioctl_run':
drivers/kvm/kvm_main.c:153: error: 'asm' operand has impossible constraints
drivers/kvm/kvm_main.c:158: error: 'asm' operand has impossible constraints
