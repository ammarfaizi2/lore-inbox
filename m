Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261922AbVAYNtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261922AbVAYNtO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 08:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVAYNtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 08:49:14 -0500
Received: from [81.2.110.250] ([81.2.110.250]:55451 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261922AbVAYNtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 08:49:12 -0500
Subject: Re: [PATCH] drivers/block/scsi_ioctl.c, Video DVD playback support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Elias da Silva <silva@aurigatec.de>
Cc: lkml <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@suse.de>
In-Reply-To: <200501251029.22646.silva@aurigatec.de>
References: <200501220327.38236.silva@aurigatec.de>
	 <200501242310.00184.silva@aurigatec.de>
	 <1106611309.6148.116.camel@localhost.localdomain>
	 <200501251029.22646.silva@aurigatec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1106656675.14787.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 25 Jan 2005 12:44:21 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-01-25 at 09:29, Elias da Silva wrote:
> On Tuesday 25 January 2005 01:01, you wrote:
> Yes, sometimes you have to risk broken software in favor of augmented
> security, but so far we only have broken software.

Well let me see in 2.6.5 if you could read open the block device at all
you could erase the drive firmware. I think we've significantly improved
security actually.

