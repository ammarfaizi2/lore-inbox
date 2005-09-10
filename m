Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932712AbVIJH3R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932712AbVIJH3R (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 03:29:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932713AbVIJH3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 03:29:17 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:4073 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932712AbVIJH3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 03:29:16 -0400
Date: Sat, 10 Sep 2005 00:28:51 -0700
From: Paul Jackson <pj@sgi.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: reiser@namesys.com, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, Reiserfs-Dev@namesys.com,
       reiserfs-list@namesys.com, edward@namesys.com
Subject: Re: List of things requested by lkml for reiser4 inclusion (to
 review)
Message-Id: <20050910002851.5b984fde.pj@sgi.com>
In-Reply-To: <5FDA2C74-F923-4695-A1B8-4355D445C073@mac.com>
References: <200509091817.39726.zam@namesys.com>
	<4321C806.60404@namesys.com>
	<20050909185740.GA11923@infradead.org>
	<4321FCDA.60305@namesys.com>
	<5FDA2C74-F923-4695-A1B8-4355D445C073@mac.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle wrote:
> Sometimes cleverness can be even worse than ordinary abuse 

I have a habit of commenting the code spots where it is not obvious
what is going on.

Someday I am going to learn that everytime I feel the compulsion
to write a "Watch out !" or "Beware !" or "Must !"  code comment,
it probably means that I am coding crap.

I usually end up ripping out the code, after some bug has whacked
my upside the head.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
