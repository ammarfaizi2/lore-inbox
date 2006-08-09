Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751344AbWHIUFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344AbWHIUFA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWHIUFA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:05:00 -0400
Received: from math.ut.ee ([193.40.36.2]:15577 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1751342AbWHIUE7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:04:59 -0400
Date: Wed, 9 Aug 2006 23:04:53 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: nathans@sgi.com
cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: XFS warning in 2.6.18-rc4
Message-ID: <Pine.SOC.4.61.0608092303570.27011@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/xfs/xfs_bmap.c: In function 'xfs_bmapi':
fs/xfs/xfs_bmap.c:2662: warning: 'rtx' is used uninitialized in this function

-- 
Meelis Roos (mroos@linux.ee)
