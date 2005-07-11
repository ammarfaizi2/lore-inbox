Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVGKCk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVGKCk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 22:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262200AbVGKCk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 22:40:57 -0400
Received: from hummeroutlaws.com ([12.161.0.3]:3078 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S262198AbVGKCky (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 22:40:54 -0400
Date: Sun, 10 Jul 2005 22:40:28 -0400
From: Jim Crilly <jim@why.dont.jablowme.net>
To: Ed Cogburn <edcogburn@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiser4 vs politics: linux misses out again
Message-ID: <20050711024028.GK3550@mail>
Mail-Followup-To: Ed Cogburn <edcogburn@hotpop.com>,
	linux-kernel@vger.kernel.org
References: <200507100510.j6A5ATun010304@laptop11.inf.utfsm.cl> <200507100848.05090.tomlins@cam.org> <200507102006.27152.adobriyan@gmail.com> <20050710202129.GA3550@mail> <dascln$lq3$1@sea.gmane.org> <20050711001814.GH3550@mail> <daslfq$4e8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daslfq$4e8$1@sea.gmane.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/05 10:43:03PM -0400, Ed Cogburn wrote:
> Jim Crilly wrote:
> 
> > but SGI doesn't release a new filesystem every 3 years with the
> > desire to remove and replace the old one.
> 
> Read Han's reply to Ed T. nearby.  This is why I should have followed my own
> original intent and not gotten back into this flamefest, as this response
> is the same kind of bullshit that's been repeated over and over again.  My
> mistake, won't happen again.

I did read Hans' reply, but why should I believe him? When I was
skimming the csets on the bk site most of the changes looked like small
fixes or code migration stuff that touched all filesystems. And I don't even 
know what 'features' he's saying were added that he didn't sanction. I
obviously didn't read all of the log entries so it's definately possible
the big stuff he's talking about was completely missed by me, but I would
bet that his > 2/3 number is prett far off because every time I give
reiser3 a try something eventually goes wrong and I end up back on XFS or
ext3 because they're more reliable.

Jim.
