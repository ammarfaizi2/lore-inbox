Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261606AbVBOBY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261606AbVBOBY1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 20:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVBOBY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 20:24:26 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:55007 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id S261591AbVBOBX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 20:23:58 -0500
From: David Lang <david.lang@digitalinsight.com>
To: lm@bitmover.com
Cc: Gerold Jury <gjury@inode.at>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Sipek <jeffpc@optonline.net>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Date: Mon, 14 Feb 2005 17:23:37 -0800 (PST)
X-X-Sender: dlang@dlang.diginsite.com
Subject: Re: [BK] upgrade will be needed
In-Reply-To: <20050215000343.GF16029@bitmover.com>
Message-ID: <Pine.LNX.4.60.0502141719560.30997@dlang.diginsite.com>
References: <20050214020802.GA3047@bitmover.com> <20050214194428.GC8763@merlin.emma.line.org>
 <20050214200544.GC16029@bitmover.com> <200502142324.43269.gjury@inode.at>
 <20050214225704.GD16029@bitmover.com> <Pine.LNX.4.60.0502141503400.30997@dlang.diginsite.com>
 <20050215000343.GF16029@bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2005 lm@bitmover.com wrote:

>> this does mean that there would be somehat of a commiter/non-commiter
>> split, with the difference between them being those who agree to the
>> non-compete license of #1 and those who don't and use #2 to have a local
>> read-only copy and have to use normal patches to submit changes up the
>> tree.
>
> And how does the CVS gateway not provide this today?  We effectively
> have exactly what you are describing.  And long ago I offered what I
> called the tarball + patch server with an open source client for all
> trees on bkbits.net - here it is:  http://lkml.org/lkml/2003/12/14/47
> If people had stopped flaming long enough to look at that it would
> be installed on bkbits today and any repo hosted there would have an
> automatic real-time gateway with no license problems.  Heck, we could
> even export the changeset comments into ChangeLog as Keith suggested
> here: http://lkml.org/lkml/2003/12/14/92 .

the advantage over CVS would be the reduced network useage (both server 
side and client side), but that's not worth the development costs you are 
quoting.

since I don't have any problem with your license I had forgotten about 
that other option. I was just trying to clarify what looked like a 
misunderstanding of what was being asked and exploring options to reduce 
the flaming.

> People didn't seem interested and I came with the conclusion, rightly or
> wrongly, that the vast majority of the people who did real work didn't
> care about the license and the noisy people just wanted to pick a fight.
> If I was wrong and this is valuable I can look into putting it up on
> bkbits.net.

unfortunantly, you are probably right :-(

David Lang


-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
