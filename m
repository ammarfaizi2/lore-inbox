Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751502AbWFPRfK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWFPRfK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 13:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751505AbWFPRfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 13:35:10 -0400
Received: from mail2.flowline.co.uk ([195.112.4.54]:8710 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1751504AbWFPRfI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 13:35:08 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: daniel+devel.linux.lkml@flexserv.de
Subject: Re: Bug: XFS internal error XFS_WANT_CORRUPTED_RETURN
Date: Fri, 16 Jun 2006 18:35:26 +0100
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <878xnx19bs.fsf@xserver.flexserv.de>
In-Reply-To: <878xnx19bs.fsf@xserver.flexserv.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606161835.26428.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 June 2006 15:09, daniel+devel.linux.lkml@flexserv.de wrote:
> Running 2.6.17-rc6
> same when running it inside a new created partition.
> No matter if on sda or inside a lvm on sdb
> Reproducible.
> Kernel is compiled with debug symbols i think.
> What additional informatiuon can i get you?

Just make sure you've run memtest for at least a couple passes to eliminate 
bad RAM. This could still easily be an XFS bug, but it's worth checking.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
