Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S129282AbRC1N0x>; Wed, 28 Mar 2001 08:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S130454AbRC1N0n>; Wed, 28 Mar 2001 08:26:43 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:29351 "EHLO math.psu.edu") by vger.kernel.org with ESMTP id <S129282AbRC1N0b>; Wed, 28 Mar 2001 08:26:31 -0500
Date: Wed, 28 Mar 2001 08:25:46 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Shawn Starr <spstarr@sh0n.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Disturbing news..
In-Reply-To: <Pine.LNX.4.30.0103280115180.7637-100000@coredump.sh0n.net>
Message-ID: <Pine.GSO.4.21.0103280815160.26500-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Mar 2001, Shawn Starr wrote:

> 
> http://news.cnet.com/news/0-1003-200-5329436.html?tag=lh
> 
> Isn't it time to change the ELF format to stop this crap?

<shrug> If you run untrusted binaries - you are screwed.  If you run
them as root - all users on your system are screwed.  If your MUA
(or browser, etc.) can run untrusted code - see above.  If you have
a dual-boot system and one of the OSes is compromised - all of them
are.  Nothing to do about that.  What's new here?  Don't be an idiot 
nd don't use crapware...

