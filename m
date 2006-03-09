Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWCIPPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWCIPPU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 10:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWCIPPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 10:15:20 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:28942 "EHLO
	sorrow.cyrius.com") by vger.kernel.org with ESMTP id S1751029AbWCIPPT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 10:15:19 -0500
Date: Thu, 9 Mar 2006 15:14:59 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel panic on PC with broken hard drive, after DMA errors
Message-ID: <20060309151459.GD2891@deprecation.cyrius.com>
References: <5Okau-77g-9@gated-at.bofh.it> <440FA916.5070703@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440FA916.5070703@shaw.ca>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Robert Hancock <hancockr@shaw.ca> [2006-03-08 22:03]:
> Probably is a genuine bug. These kinds of reports have come up a few
> times recently as I recall - it seems some of the error handling in
> the drivers/ide code isn't quite so robust..

Was the traceback I posted enough so someone can find out what's going
on or do you need more information?  I can hook up a serial console
and try to capture the full log, but I'm not sure I can reproduce this
kernel panic.  The dying hard drive is quite arbitrary when it comes
to showing errors or working fine...
-- 
Martin Michlmayr
http://www.cyrius.com/
