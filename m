Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbULBRwF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbULBRwF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 12:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbULBRuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 12:50:03 -0500
Received: from adsl.a2000.nu ([80.126.253.168]:18567 "EHLO adsl.a2000.nu")
	by vger.kernel.org with ESMTP id S261684AbULBRtv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 12:49:51 -0500
Date: Thu, 2 Dec 2004 18:49:46 +0100 (CET)
From: Stephan van Hienen <kernel@a2000.nu>
To: Andreas Dilger <adilger@clusterfs.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: nfs and LBD support (2TB+)
In-Reply-To: <20041201234619.GO22547@schnapps.adilger.int>
Message-ID: <Pine.LNX.4.61.0412021848050.16787@adsl.a2000.nu>
References: <Pine.LNX.4.61.0412020017550.2774@adsl.a2000.nu>
 <20041201234619.GO22547@schnapps.adilger.int>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2004, Andreas Dilger wrote:

> Are you running NFS v3 or v2?  I _think_ there is a 2T limit for NFS v2.
not sure
i have support for nfs2 and 3 compiled in both kernels
so i think it's running 3 ?
(how can i check, it doesn't show with mount)

btw another system sun ultrasparc running 2.4.20 show the mount ok
(2TB+)
