Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269157AbUINGSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269157AbUINGSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 02:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269152AbUINGSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 02:18:15 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:26039 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269063AbUINGSM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 02:18:12 -0400
Date: Tue, 14 Sep 2004 08:16:43 +0200
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Cc: len.brown@intel.com
Subject: [ACPI Debug] String: Length 0x0F, "Entering RTMP()"
Message-ID: <20040914061641.GD2336@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.6.9-rc2 is throwing a lot of these errors on my system:

[ACPI Debug] String: Length 0x0F, "Entering RTMP()"
[ACPI Debug] String: Length 0x0F, "Entering TIN2()"
[ACPI Debug] String: Length 0x0F, "Existing RTMP()"

About 450 of these three lines repeated so far, seem to get one every 5
seconds or so. Box is an Athlon64 solo, let me know if you want more
info (and what).

-- 
Jens Axboe

