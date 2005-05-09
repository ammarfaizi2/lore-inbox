Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263041AbVEIEPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbVEIEPP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 00:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263042AbVEIEPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 00:15:15 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:7279 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S263041AbVEIEPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 00:15:09 -0400
X-IronPort-AV: i="3.92,167,1112590800"; 
   d="scan'208"; a="240742848:sNHT23103944"
Date: Sun, 8 May 2005 23:15:04 -0500
From: Matt Domsch <Matt_Domsch@dell.com>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org, matthew.e.tolentino@intel.com, akpm@osdl.org
Subject: Re: [PATCH] kfree cleanups for drivers/firmware/
Message-ID: <20050509041504.GA5986@lists.us.dell.com>
References: <Pine.LNX.4.62.0505090009540.2440@dragon.hyggekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0505090009540.2440@dragon.hyggekrogen.localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 at 12:15:12AM +0200, Jesper Juhl wrote:
> Here's a patch with kfree() cleanups for drivers/firmware/efivars.c
> Patch removes redundant NULL checks before kfree and also makes a small 
> whitespace cleanup - moves two statements on same line to sepperate lines.
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

Ack'd-by: Matt Domsch <Matt_Domsch@dell.com>

Thanks,
Matt

-- 
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
