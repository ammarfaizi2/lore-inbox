Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbUDAWmv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 17:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbUDAWmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 17:42:51 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:24841 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262536AbUDAWmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 17:42:49 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: disable-cap-mlock
Date: Fri, 2 Apr 2004 00:43:13 +0200
User-Agent: KMail/1.6.1
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>, kenneth.w.chen@intel.com
References: <20040401135920.GF18585@dualathlon.random> <20040401115252.7cdb9d6f.akpm@osdl.org> <20040401223619.GB18585@dualathlon.random>
In-Reply-To: <20040401223619.GB18585@dualathlon.random>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404020043.13725@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 April 2004 00:36, Andrea Arcangeli wrote:

Hey Andrea,

> > Could you please refresh-n-send the RLIMIT_MEMLOCK patch?

> I asked it to Rik too but he redirected me at some rpm, but luckily
> Marc-Christian extracted it and he posted it on l-k some week ago, so
> you can just check l-k (From: Marc-Christian) and you'll find it. It's
> against 2.4 however. Problem is that it's absolutely useless for the
> problem I had to solve, or I would be using it already instead.

hehe. Well. I have this flying around on my hard disk. 

root@codeman:[/usr/src/patches/distribution] # du -skh .
1702M    .

almost every interesting distribution kernels are located there in extracted 
form :)

It's actually this one: 
http://marc.theaimsgroup.com/?l=linux-kernel&m=107980096115231&w=2

(won't post the patch again to save lkml space ;)

ciao, Marc
