Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262220AbVAECvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVAECvj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 21:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVAECvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 21:51:39 -0500
Received: from fmr19.intel.com ([134.134.136.18]:15339 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S262220AbVAECvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 21:51:36 -0500
Subject: [PATCH 0/4]Bind physical devices with ACPI devices - take 2
From: Li Shaohua <shaohua.li@intel.com>
To: ACPI-DEV <acpi-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Cc: Len Brown <len.brown@intel.com>, Greg <greg@kroah.com>,
       Patrick Mochel <mochel@digitalimplant.org>,
       Pavel Machek <pavel@suse.cz>
Content-Type: text/plain
Message-Id: <1104893444.5550.127.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 05 Jan 2005 10:50:45 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The series of patches implement binding physical devices with ACPI
devices. With it, device drivers can utilize methods provided by
firmware (ACPI). These patches are against 2.6.10, please give your
comments.

Thanks,
Shaohua

