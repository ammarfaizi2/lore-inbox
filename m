Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268348AbTBSKns>; Wed, 19 Feb 2003 05:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268350AbTBSKns>; Wed, 19 Feb 2003 05:43:48 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:18406 "EHLO
	hotmale.blue-labs.org") by vger.kernel.org with ESMTP
	id <S268348AbTBSKnr>; Wed, 19 Feb 2003 05:43:47 -0500
Message-ID: <3E536237.8010502@blue-labs.org>
Date: Wed, 19 Feb 2003 05:53:43 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030209
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.62
References: <Pine.LNX.4.44.0302171515110.1150-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0302171515110.1150-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.60+ is rather unstable for me on an Athlon CPU w/ gcc 3.2.2.  If I'm 
careful and do very little in X, it seems to stay up for a few days.  If 
I do any sort of fast graphics or sound, etc, it'll die very quickly.  
'tis an instant death with no OOPS, nothing at all on screen, nothing on 
serial console.

Just an FYI, I'm trying to narrow it down.

David

Linus Torvalds wrote:

>Hmm.. Mostly lots of small updates, although the merge with Andrew
>included the RCU dcache patches from IBM that he has carried along for a
>while (ie fairly fundamnetal, but also very well tested).
>
>ARM, PPC, PPC64, alpha, kbuild.
>
>Oh, and as a sign that 2.6.x really _is_ approaching, people have started 
>sending me spelling fixes. Kernel coders are apparently all atrocious 
>spellers, and for some reason the spelling police always comes out of the 
>woodwork when stable releases get closer.
>  
>

