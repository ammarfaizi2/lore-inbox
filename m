Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268447AbTBSNIk>; Wed, 19 Feb 2003 08:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268452AbTBSNIk>; Wed, 19 Feb 2003 08:08:40 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:8453 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S268447AbTBSNIj>; Wed, 19 Feb 2003 08:08:39 -0500
Message-ID: <3E538479.1040305@aitel.hist.no>
Date: Wed, 19 Feb 2003 14:19:53 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: a really annoying feature of the config menu structure
References: <Pine.LNX.4.44.0302181604310.23007-100000@dell>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert P. J. Day wrote:
>   i finally decided to get serious and start looking at the
> overall config menu structure, to re-arrange the menus and
> submenus so that it made more sense and flowed more logically,
[...]
>   other areas where this would have made sense would be for
> something like a "Networking" main menu, with submenus for
> things like ISDN, Wireless and so on, those all being 
> subsets of networking.  

It isn't that simple.  ISDN is more than networking, and even
useable without it.  Non-network uses of isdn:

* Making an answering machine or voicemail from a pc
and one or more isdn cards.
* Use isdn for dialing into non-IP services like a BBS.

So you have a choice between sticking all networking
things in a network menu (and have stuff like ISDN
spread out in different places (network and other ISDN at least)

or put all ISDN in one plave and have network etc. spread over
various networking technologies like today.

There is no config layout that is "clean" for everybody,
because it is fundamentally trying to stuff a generic graph
into a hierarchical tree.

Helge Hafting

