Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTH2P2s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 11:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbTH2P2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 11:28:47 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:47489 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S261352AbTH2P2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 11:28:45 -0400
Message-ID: <3F4F7129.1050506@wmich.edu>
Date: Fri, 29 Aug 2003 11:28:41 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030722
X-Accept-Language: en
MIME-Version: 1.0
To: Alex Tomas <bzzz@tmi.comex.ru>
CC: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
Subject: Re: [RFC] extents support for EXT3
References: <m33cfm19ar.fsf@bzzz.home.net> <3F4E4605.6040706@wmich.edu> <m3vfshrola.fsf@bzzz.home.net>
In-Reply-To: <m3vfshrola.fsf@bzzz.home.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Tomas wrote:
>>>>>>Ed Sweetman (ES) writes:
> 
> 
>  ES> This patch seems to be against test2, just wondering if anyone before
>  ES> me has used it on the latest test release.  If not then i'm gonna do
>  ES> something stupid and be the first.
> 
> I would be happy to see anyone trying this patch ;)
> 
> following patch applies to -test4 o





If it's the same as test2 then i've already tried it.  I got no 
performance gains as far as dbench is concerned.  Perhaps my block size 
is not optimal on that partition for extents.  Either way it seemed to 
make the kernel unstable and i've been trying to fix things since 
mid-day yesterday.  Been getting very strange problems, no error 
messages are reported or anything like that.




