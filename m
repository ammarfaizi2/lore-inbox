Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261382AbVCVPrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261382AbVCVPrk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 10:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbVCVPrk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 10:47:40 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:14799 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261382AbVCVPrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 10:47:39 -0500
Date: Tue, 22 Mar 2005 16:47:36 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-kernel@vger.kernel.org
cc: Phillip Lougher <phillip@lougher.demon.co.uk>
Subject: Squashfs without ./..
Message-ID: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,


I have observed that squashfs, when mounted, does not return any "." or ".." 
pseudo-directories upon readdir.
Could this be added? Would there be any objections?


Jan Engelhardt
-- 
