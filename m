Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbVDLBaN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbVDLBaN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 21:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbVDLBaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 21:30:13 -0400
Received: from [221.216.56.203] ([221.216.56.203]:14826 "EHLO
	adam.yggdrasil.com") by vger.kernel.org with ESMTP id S261873AbVDLBaG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 21:30:06 -0400
Date: Mon, 11 Apr 2005 18:20:18 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200504120120.j3C1KII14991@adam.yggdrasil.com>
To: pasky@ucw.cz
Subject: Re: Re: GIT license (Re: Re: Re: Re: Re: [ANNOUNCE] git-pasky-0.1)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Apr 2005 20:45:38 +0200, Peter Baudis wrote:
>  Hello,

>  please do not trim the cc list so agressively.

Sorry.  I read the list from a web site that does not show the
cc lists.  I'll try to cc more people from the relevant discussions
though.  On the other hand, I've dropped Linus from this message,
as it just points to something he previously said.

>Dear diary, on Mon, Apr 11, 2005 at 05:46:38PM CEST, I got a letter
>where "Adam J. Richter" <adam@yggdrasil.com> told me that...
>..snip..
>> Graydon Hoare.  (By the way, I would prefer that git just punt to
>> user level programs for diff and merge when all of the versions
>> involved are different or at least have a very thin interface
>> for extending the facility, because I would like to do some character
>> based merge stuff.)
>..snip..

>But this is what git already does. I agree it could do it even better,
>by checking environment variables for the appropriate tools (then you
>could use that to pass diff e.g. -p etc.).

This message from Linus seemed to imply that git was going to get
its own 3-way merge code:

| Then the bad news: the merge algorithm is going to suck. It's going to be
| just plain 3-way merge, the same RCS/CVS thing you've seen before. With no
| understanding of renames etc. I'll try to find the best parent to base the
| merge off of, although early testers may have to tell the piece of crud
| what the most recent common parent was.

( from http://marc.theaimsgroup.com/?l=linux-kernel&m=111320013100822&w=2 )


                    __     ______________
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
