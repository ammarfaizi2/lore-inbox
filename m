Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422974AbWAMVUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422974AbWAMVUS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 16:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422980AbWAMVUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 16:20:18 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:10675 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1422974AbWAMVUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 16:20:17 -0500
Date: Fri, 13 Jan 2006 21:27:17 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Quota on xfs vfsroot
Message-ID: <Pine.LNX.4.61.0601132126110.25429@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


the xfs_quota manpage says that one needs to use the "root-flags=" boot 
parameter to enable quota for the root filesystem, but I do not see a 
matching __setup() definition anywhere in the fs/xfs/ folder. So, how do I 
have quota activated then?


Jan Engelhardt
-- 
