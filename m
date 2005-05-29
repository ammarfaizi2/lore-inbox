Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVE2S00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVE2S00 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 14:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVE2S00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 14:26:26 -0400
Received: from titan.genwebhost.com ([209.9.226.66]:57305 "EHLO
	titan.genwebhost.com") by vger.kernel.org with ESMTP
	id S261377AbVE2S0X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 14:26:23 -0400
Date: Sun, 29 May 2005 11:25:23 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: sean@capitalgenomix.com
Cc: linux-kernel@vger.kernel.org, webmaster@kernel.org
Subject: Re: Kernel Version Explanation
Message-Id: <20050529112523.17f6e8fa.rdunlap@xenotime.net>
In-Reply-To: <20050529140945.GA4815@cgx-mail.capitalgenomix.com>
References: <20050529140945.GA4815@cgx-mail.capitalgenomix.com>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 May 2005 09:09:45 -0500 sean@capitalgenomix.com wrote:

| Would it be possible to get an explanation of the new kernel version
| format put onto the http://www.kernel.org website?  If it's there and
| I'm missing it, feel free to call me all kinds of silly names; but can
| you please send me a link?

Can you be more explicit in what you are looking for?

If you click on 'prepatch', 'snapshot', '-ac patch', and '-mm patch',
you can read some explanations.  What is missing there?


It looks to me like the word "stable" is overused on the main page
at www.kernel.org .  I would also prefer to see all of the 2.6.*
kernel versions together, above the 2.4.*, 2.2.*, and 2.0.* lines.



E.g. (however, this is too cluttered IMO; the prepatch/-ac/-mm
links do this well without the clutter):

The latest stable version of the Linux kernel is:  	2.6.11.11
The stable kernel patchset contains only critical and security patches
to the latest 2.6.x kernel.

The latest prepatch for the stable Linux kernel tree is:  	2.6.12-rc5
This is the mainline kernel where all new patches are added.
If they are not critical, they usually go thru the -mm patchset
before being merged here.  If they are critical, they may be
merged here first.

The latest -mm patch to the stable Linux kernels is:  	2.6.12-rc5-mm1 	
This is the development tree for 2.6 kernels.  Patches are
generally merged here for testing before being merged into
the mainline kernel tree.

The latest -ac patch to the stable Linux kernels is:  	2.6.11-ac7
(see the -ac patch explanation)


Thanks,
---
~Randy
