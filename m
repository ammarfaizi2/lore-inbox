Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267417AbSLRUBT>; Wed, 18 Dec 2002 15:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267421AbSLRUBT>; Wed, 18 Dec 2002 15:01:19 -0500
Received: from fmr06.intel.com ([134.134.136.7]:57835 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S267417AbSLRUBS>; Wed, 18 Dec 2002 15:01:18 -0500
Message-ID: <8A9A5F4E6576D511B98F00508B68C20A1508E3D8@orsmsx106.jf.intel.com>
From: "Shureih, Tariq" <tariq.shureih@intel.com>
To: "Lmkl (linux-kernel@vger.kernel.org)" <linux-kernel@vger.kernel.org>
Subject: QM_MODULES: Function not implemented
Date: Wed, 18 Dec 2002 12:09:10 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This may be a simple error on my part but I've tried everything.

 

Kernel: 2.5.51

SCSI driver compiled static

 

Kernel boots just fine, howeverl, "lsmod" gives me a messages: "QM_MODULES:
Function not implemented"

I checked my kernel configuration and Modules support is enabled and kernel
module loader is enabled.

 

Any ideas?

 

*_*_*_*_*_*

Tariq Shureih

Opinions are my own and don't represent my employer


