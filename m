Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262017AbVCZKkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbVCZKkn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 05:40:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbVCZKkn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 05:40:43 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:6099 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262017AbVCZKkb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 05:40:31 -0500
Date: Sat, 26 Mar 2005 11:40:27 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: gettimeofday call
Message-ID: <Pine.LNX.4.61.0503261139490.3958@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,


I suppose that calling gettimeofday() repeatedly (to add a timestamp to 
some data) within the kernel is cheaper than doing it in userspace, is it?


Jan Engelhardt
-- 
No TOFU for me, please.
