Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbTKHR2y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 12:28:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTKHR2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 12:28:54 -0500
Received: from havoc.gtf.org ([63.247.75.124]:50399 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S261889AbTKHR2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 12:28:53 -0500
Date: Sat, 8 Nov 2003 12:26:21 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK PATCHES] libata fixes
Message-ID: <20031108172621.GA8041@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, please do a

	bk pull bk://gkernel.bkbits.net/libata-2.5

This will update the following files:

 drivers/scsi/libata.h       |    2 +-
 drivers/scsi/sata_promise.c |   18 ++++++++++++++----
 2 files changed, 15 insertions(+), 5 deletions(-)

through these ChangeSets:

<jgarzik@redhat.com> (03/11/07 1.1417)
   [libata] fix Promise PCI posting bugs

<jgarzik@redhat.com> (03/11/06 1.1416)
   [libata] bump libata version

<jgarzik@redhat.com> (03/11/06 1.1415)
   [libata] fix ugly Promise interrupt masking bug

