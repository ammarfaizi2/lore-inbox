Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261489AbSJYQvN>; Fri, 25 Oct 2002 12:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261490AbSJYQvN>; Fri, 25 Oct 2002 12:51:13 -0400
Received: from 1-116.ctame701-1.telepar.net.br ([200.181.137.116]:43191 "EHLO
	1-116.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261489AbSJYQvM>; Fri, 25 Oct 2002 12:51:12 -0400
Date: Fri, 25 Oct 2002 14:57:09 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: James Cleverdon <jamesclv@us.ibm.com>
cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Kswapd madness in 2.4 kernels
In-Reply-To: <200210242026.13071.jamesclv@us.ibm.com>
Message-ID: <Pine.LNX.4.44L.0210251456210.1995-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44L.0210251456212.1995@imladris.surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2002, James Cleverdon wrote:

> We have some customers with some fairly beefy servers.  They can get the
> system into an unusable state that has been reported on lkml before.

> The two attached patches applied to 2.4.19 fix the problem on our test boxes.
>
> Are these patches still considered a good idea for 2.4?  Is there something
> better I should be using?

Yes, these patches are a good idea.  I'm curious why they
haven't been submitted to Marcelo yet ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

