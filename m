Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUAGEkQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 23:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266106AbUAGEkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 23:40:16 -0500
Received: from lists.us.dell.com ([143.166.224.162]:43444 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S266069AbUAGEkN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 23:40:13 -0500
Date: Tue, 6 Jan 2004 22:40:01 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: Eric Moore <emoore@lsil.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       'James.Bottomley@steeleye.com'
Subject: Re: [PATCH] 2.6.1-rc2 - MPT Fusion driver 3.00.00 update
Message-ID: <20040106224001.A27675@lists.us.dell.com>
References: <3FFB4E0F.704@lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3FFB4E0F.704@lsil.com>; from emoore@lsil.com on Tue, Jan 06, 2004 at 05:08:47PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 06, 2004 at 05:08:47PM -0700, Eric Moore wrote:
> Here's an driver update for mpt fusion driver version 3.00.00.

Eric, since this is for 2.6.x, need the driver export anything in
/proc anymore, preferring to export via sysfs instead?

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
