Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266465AbUJLROQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266465AbUJLROQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 13:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266316AbUJLRM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 13:12:57 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:53903 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S266349AbUJLRKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 13:10:15 -0400
Subject: Re: [PATCH] QStor SATA/RAID driver for 2.6.9-rc3
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <lkml@rtr.ca>, Christoph Hellwig <hch@infradead.org>,
       Mark Lord <lsml@rtr.ca>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20041012170526.GB9274@havoc.gtf.org>
References: <4165A85D.7080704@rtr.ca> <4165AB1B.8000204@pobox.com>
	<4165ACF8.8060208@rtr.ca> <20041007221537.A17712@infradead.org>
	<1097241583.2412.15.camel@mulgrave> <4166AF2F.6070904@rtr.ca>
	<1097249266.1678.40.camel@mulgrave> <4166B37D.8030701@rtr.ca>
	<1097251299.1928.56.camel@mulgrave> <416C0DC5.2080206@rtr.ca> 
	<20041012170526.GB9274@havoc.gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 12 Oct 2004 12:09:55 -0500
Message-Id: <1097601002.1763.84.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-12 at 12:05, Jeff Garzik wrote:
> I'll respectfully disagree with James...  I think the most prudent
> course of action is to follow the example of SCSI common code.
> 
> If the SCSI core is doing something wrong, we should fix that _first_,
> not set a precedent of confusing dissociation.
> 
> Everyone knows that Linux programmers engineer with their cut-n-paste
> feature.

So you'll be sending me the patches that do this?

James


