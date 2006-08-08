Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030204AbWHHRrq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030204AbWHHRrq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 13:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030206AbWHHRrq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 13:47:46 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:24001 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1030204AbWHHRrp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 13:47:45 -0400
Date: Tue, 8 Aug 2006 19:47:27 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: netdev@vger.kernel.org
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.18-rc4
In-Reply-To: <Pine.LNX.4.64.0608061127070.5167@g5.osdl.org>
Message-ID: <Pine.LNX.4.61.0608081943470.18225@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0608061127070.5167@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>It's been a week since -rc3, so now we have a -rc4.

2.6.18 comes with ipt_statistic, but there is no way from userspace 
(iptables) to use it (libipt_statistic.so simply does not come with the 
latest iptables from svn). Does someone know what's going on?



Jan Engelhardt
-- 
