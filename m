Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264388AbUGAJsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264388AbUGAJsd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 05:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264389AbUGAJsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 05:48:33 -0400
Received: from dirac.phys.uwm.edu ([129.89.57.19]:24963 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S264388AbUGAJsc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 05:48:32 -0400
Date: Thu, 1 Jul 2004 04:48:30 -0500 (CDT)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: costa@tecgraf.puc-rio.br, tomstdenis@yahoo.com,
       Nick Warne <nick@ukfsn.org>
Subject: Re: 2.4.26: IDE drives become unavailable randomly
In-Reply-To: <40E2E7EF.15243.10093E4E@localhost>
Message-ID: <Pine.GSO.4.21.0407010446090.2056-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was getting this problem, and advice from smartmontools people was 
> to clean out the box and reseat all cables etc.  Seemed to work for 
> me on the box at work with this DMA timeout issue - BTW, always 
> happened at idle, like 2:15am in the middle of the night etc.
> 
> Reference: 
> http://sourceforge.net/mailarchive/message.php?msg_id=8660397
> http://sourceforge.net/mailarchive/forum.php?thread_id=4908273&forum_i
> d=12495

An additional reference. See the entry that starts 'System freezes under
heavy load" in:
http://cvs.sourceforge.net/viewcvs.py/smartmontools/sm5/WARNINGS?view=markup

Cheers,
	Bruce

