Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVBOADz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVBOADz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 19:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVBOADz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 19:03:55 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:37321 "EHLO
	mail.bitmover.com") by vger.kernel.org with ESMTP id S261377AbVBOADt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 19:03:49 -0500
Date: Mon, 14 Feb 2005 16:03:43 -0800
To: David Lang <david.lang@digitalinsight.com>
Cc: Gerold Jury <gjury@inode.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Sipek <jeffpc@optonline.net>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [BK] upgrade will be needed
Message-ID: <20050215000343.GF16029@bitmover.com>
Mail-Followup-To: lm@bitmover.com,
	David Lang <david.lang@digitalinsight.com>,
	Gerold Jury <gjury@inode.at>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jeff Sipek <jeffpc@optonline.net>,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
References: <20050214020802.GA3047@bitmover.com> <20050214194428.GC8763@merlin.emma.line.org> <20050214200544.GC16029@bitmover.com> <200502142324.43269.gjury@inode.at> <20050214225704.GD16029@bitmover.com> <Pine.LNX.4.60.0502141503400.30997@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0502141503400.30997@dlang.diginsite.com>
User-Agent: Mutt/1.5.6+20040907i
From: lm@bitmover.com (Larry McVoy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2005 at 03:23:47PM -0800, David Lang wrote:
> Larry, I don't think he's talking about making the free bk be a striped 
> down version, I think he's talking about having two different free 
> versions.

Leaving aside the $600K/year or so it would cost us to do that...

> this does mean that there would be somehat of a commiter/non-commiter 
> split, with the difference between them being those who agree to the 
> non-compete license of #1 and those who don't and use #2 to have a local 
> read-only copy and have to use normal patches to submit changes up the 
> tree.

And how does the CVS gateway not provide this today?  We effectively
have exactly what you are describing.  And long ago I offered what I
called the tarball + patch server with an open source client for all
trees on bkbits.net - here it is:  http://lkml.org/lkml/2003/12/14/47
If people had stopped flaming long enough to look at that it would 
be installed on bkbits today and any repo hosted there would have an
automatic real-time gateway with no license problems.  Heck, we could
even export the changeset comments into ChangeLog as Keith suggested
here: http://lkml.org/lkml/2003/12/14/92 .  

People didn't seem interested and I came with the conclusion, rightly or
wrongly, that the vast majority of the people who did real work didn't
care about the license and the noisy people just wanted to pick a fight.
If I was wrong and this is valuable I can look into putting it up on
bkbits.net.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
