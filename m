Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310529AbSCKRyd>; Mon, 11 Mar 2002 12:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310530AbSCKRyP>; Mon, 11 Mar 2002 12:54:15 -0500
Received: from austin.openmic.com ([216.143.252.250]:59659 "EHLO
	austin.openmic.com") by vger.kernel.org with ESMTP
	id <S310525AbSCKRyC>; Mon, 11 Mar 2002 12:54:02 -0500
Message-ID: <3C8CEF22.1050602@greshamstorage.com>
Date: Mon, 11 Mar 2002 11:53:38 -0600
From: "Jonathan A. George" <JGeorge@greshamstorage.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020226
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
In-Reply-To: <Pine.LNX.4.33L2.0203110911530.3326-100000@dragon.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Larry McVoy wrote:

>Arch has a concept of an "inode" quite similar to BitKeeper, in fact
>one wonders where the idea came from :-)
>
Oh please.  I've used the concept of an "inode" for years when modeling 
the information related to filesystem attributes simply because that is 
what the filesystem itself uses, and when modeling something in a 
filesystem the concept is self evident.  I'm certain that every deep 
version control system has a similar model (i.e. Clearcase which 
explicitly is a filesystem)...  It's not as if people are unaware of the 
deficiencies of CVS and other free software version control systems, 
they simply haven't yet invested the time to polish them because the 
development cost failed the cost benefit analysis test for them.

I must give you credit for stirring things up and showing how great the 
benefits are of a polished SCM system to the free software community. 
 However, between my computer science background and use of various 
commercial SCM systems I see great polish and followthrough in 
bitkeeper, but not much true originality.  In other words your dig at 
Tom was really out of line.

--Jonathan--

