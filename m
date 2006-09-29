Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161211AbWI2A0J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161211AbWI2A0J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 20:26:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161209AbWI2A0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 20:26:09 -0400
Received: from havoc.gtf.org ([69.61.125.42]:30599 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161206AbWI2A0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 20:26:06 -0400
Date: Thu, 28 Sep 2006 20:26:01 -0400
From: Jeff Garzik <jeff@garzik.org>
To: linux-ide@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/5] libata: various queued changes
Message-ID: <20060929002601.GA7397@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These five patches are random bits I've queued in
libata-dev.git#upstream:

[libata] Use new PCI_VDEVICE() macro to dramatically shorten ID lists
[libata] minor PCI IDE probe fixes and cleanups
[libata] init probe_ent->private_data in a common location
[libata] Print out Status register, if a BSY-sleep takes too long
[libata] PCI ID table cleanup in various drivers

