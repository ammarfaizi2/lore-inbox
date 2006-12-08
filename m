Return-Path: <linux-kernel-owner+willy=40w.ods.org-S938027AbWLHLBF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938027AbWLHLBF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 06:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938030AbWLHLBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 06:01:00 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:58061 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S938027AbWLHLA6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 06:00:58 -0500
Date: Fri, 8 Dec 2006 11:51:40 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
cc: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, akpm@osdl.org, hch@infradead.org,
       viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 15/35] Unionfs: Common file operations
In-Reply-To: <20061208041656.GB14363@filer.fsl.cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612081148570.12227@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <11652354702903-git-send-email-jsipek@cs.sunysb.edu>
 <Pine.LNX.4.61.0612052155150.18570@yvahk01.tjqt.qr>
 <20061208041656.GB14363@filer.fsl.cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 7 2006 23:16, Josef Sipek wrote:
>> I think there was an ioctl for files to find out where a particular
>> file lives on disk.
>
>That's the UNIONFS_IOCTL_QUERYFILE case.

No I meant something that works on all filesystems, something generic, not
unionfs-based.


	-`J'
-- 
