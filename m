Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVATR61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVATR61 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 12:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVATRyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 12:54:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:28062 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261402AbVATRwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 12:52:08 -0500
Message-Id: <200501201752.j0KHq7a04712@mail.osdl.org>
To: linux-kernel@vger.kernel.org
Subject: [OSDL] - reaim results graphed 2.6.11-rc1
Date: Thu, 20 Jan 2005 09:52:07 -0800
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


graphs comparing 2.6.11-rc1 to 2.6.9:
http://developer.osdl.org/cliffw/reaim/compares/2.6.9vs11-rc1/

.html files are named:
<workload>_<filesystem>_<number of cpus>.html

Only notworthy event is apparent regression in reiserfs performance
using the fileserever workload:

http://developer.osdl.org/cliffw/reaim/compares/2.6.9vs11-rc1/new_fserver_reiserfs_2.html

graphs comparing 2.6.11-rc1 to 2.6.10:
http://developer.osdl.org/cliffw/reaim/compares/2.6.10vs11-rc1/

Reisefs regression vs 2.6.10:
http://developer.osdl.org/cliffw/reaim/compares/2.6.10vs11-rc1/new_fserver_reiserfs_2.html

XFS performance also declined. slightly:
http://developer.osdl.org/cliffw/reaim/compares/2.6.10vs11-rc1/new_fserver_xfs_2.html
---------------
cliffw


