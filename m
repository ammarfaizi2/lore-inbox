Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262342AbVC2LIJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262342AbVC2LIJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 06:08:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbVC2LIJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 06:08:09 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:50918 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262342AbVC2LIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 06:08:05 -0500
Date: Tue, 29 Mar 2005 13:08:03 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Block device size
Message-ID: <Pine.LNX.4.61.0503291306020.19483@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,


how can I found out the size of the underlying block device when I am in 
somefs_fill_super()?


Jan Engelhardt
-- 
No TOFU for me, please.
