Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751741AbWCDSq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751741AbWCDSq0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 13:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbWCDSq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 13:46:26 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:15076 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751582AbWCDSqZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 13:46:25 -0500
Date: Sat, 4 Mar 2006 19:46:22 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Chris Leech <christopher.leech@intel.com>
cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/8] Intel I/O Acceleration Technology (I/OAT)
In-Reply-To: <20060303214036.11908.10499.stgit@gitlost.site>
Message-ID: <Pine.LNX.4.61.0603041945520.29991@yvahk01.tjqt.qr>
References: <20060303214036.11908.10499.stgit@gitlost.site>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>This patch series is the first full release of the Intel(R) I/O
>Acceleration Technology (I/OAT) for Linux.  It includes an in kernel API
>for offloading memory copies to hardware, a driver for the I/OAT DMA memcpy
>engine, and changes to the TCP stack to offload copies of received
>networking data to application space.
>
Does this buy the normal standard desktop user anything?


Jan Engelhardt
-- 
