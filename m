Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261835AbVCQFKa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261835AbVCQFKa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 00:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263001AbVCQFKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 00:10:30 -0500
Received: from fire.osdl.org ([65.172.181.4]:60038 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261835AbVCQFK1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 00:10:27 -0500
Date: Wed, 16 Mar 2005 21:11:20 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200503170511.j2H5BKw3025220@ibm-f.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.11 - 2005-03-16.16.00) - 2 New warnings
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/NCR5380.c:703: warning: 'NCR5380_proc_info' defined but not used
drivers/scsi/NCR5380.c:703: warning: 'notyet_generic_proc_info' defined but not used
