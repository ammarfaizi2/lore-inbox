Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbVKUUh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbVKUUh7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 15:37:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVKUUh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 15:37:59 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:4133 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932188AbVKUUh6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 15:37:58 -0500
Message-ID: <438230B6.8070503@tmr.com>
Date: Mon, 21 Nov 2005 15:40:22 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Sun's ZFS and Linux
References: <9611fa230511181538g3e8ec403uafa9ed32b560fb0c@mail.gmail.com> <20051119172337.GA24765@thunk.org>
In-Reply-To: <20051119172337.GA24765@thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> On Fri, Nov 18, 2005 at 11:38:16PM +0000, Tarkan Erimer wrote:
> 
>>On Nov.16, Sun has open sourced the
>>(http://www.opensolaris.org/os/announcements/#2005-11-16_welcome_to_the_zfs_community_
>>) ZFS. I know that, It is licensed under CDDL. So, It is not GPL
>>compatible. In this situation, there is no way for Linux mainline. But
>>I wonder, is there anybody has a plan to port ZFS for Linux as a
>>separate patch ?
> 
> 
> That wouldn't be a "port", it would have to be a complete
> reimplementation from scratch.  And, of course, of further concern
> would be whether or not there are any patents that Sun may have filed
> covering ZFS.  If the patents have only been licensed for CDDL
> licensed code, then that won't help a GPL'ed covered reimplementation.
> 
What a great chance to try out userfs.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
