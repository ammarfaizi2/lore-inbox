Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVC2MWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVC2MWS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 07:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVC2MWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 07:22:17 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:63212 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262240AbVC2MWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 07:22:06 -0500
Date: Tue, 29 Mar 2005 14:22:01 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Block device size
Message-ID: <Pine.LNX.4.61.0503291419180.19483@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As a response to myself, I've found it:
	superblock->s_bdev->bd_inode->i_size
:)


Jan Engelhardt
-- 
No TOFU for me, please.
