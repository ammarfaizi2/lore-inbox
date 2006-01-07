Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030434AbWAGFSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030434AbWAGFSF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 00:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030463AbWAGFSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 00:18:04 -0500
Received: from xenotime.net ([66.160.160.81]:64914 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030434AbWAGFSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 00:18:02 -0500
Date: Fri, 6 Jan 2006 21:17:57 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: dax@gurulabs.com, erich@areca.com.tw, arjan@infradead.org,
       oliver@neukum.org, rlrevell@joe-job.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: [PATCH] Areca RAID driver (arcmsr) cleanups
Message-Id: <20060106211757.20770379.rdunlap@xenotime.net>
In-Reply-To: <20060104011841.036ea510.akpm@osdl.org>
References: <1135228831.4122.15.camel@mentorng.gurulabs.com>
	<1135229681.439.23.camel@mindpipe>
	<200512220917.41494.oliver@neukum.org>
	<1135239601.2940.5.camel@laptopd505.fenrus.org>
	<20051222052443.57ffe6f9.akpm@osdl.org>
	<1135279895.19320.24.camel@mentorng.gurulabs.com>
	<20051230113227.2b787d43.rdunlap@xenotime.net>
	<20060104011841.036ea510.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Unfortunately I've gone and applied a huge driver update from Erich, so
> none of this applies any more.
> 
> A recut would be appreciated.  Please include your additional suggestions:
> In the updated changelog, thanks.

The recut is huge -- too large to mail (> 260 KB).

http://www.xenotime.net/linux/patches/arcmsr-rollup.patch

---
~Randy
