Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVEIXu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVEIXu2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 19:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVEIXu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 19:50:28 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:13200 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261377AbVEIXuV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 19:50:21 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [patch 0/6] latest bugfixes for 2.6.12
Date: Tue, 10 May 2005 01:39:00 +0200
User-Agent: KMail/1.8
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       bstroesser@fujitsu-siemens.com
References: <200505100110.16920.blaisorblade@yahoo.it> <20050509164546.0d6d136b.akpm@osdl.org>
In-Reply-To: <20050509164546.0d6d136b.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505100139.02512.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 May 2005 01:45, Andrew Morton wrote:
> Blaisorblade <blaisorblade@yahoo.it> wrote:
> > Here are some more fixes intended for 2.6.12 (and well tested). Can you
> > merge them soon, Andrew? Thanks.
>
> Sure.

> > The first is a particularly bad one since it shows up when you *start*
> > compiling UML (due to a quilt patch -> normal patch conversion problem, a
> > file wasn't actually deleted, but it was when applied through quilt). Was
> > this too quick a merge, maybe? What's your "merging policy" (if any) for
> > patches?

> Jeff sent in fixes which were dependent on other things I had, we're maybe
> several weeks away from 2.6.12,
Several weeks away? Ok, that's nice to know, so we are not in a hurry 
(especially since I'm totally busy). When I'll have time I'll flush out the 
rest of what I have in my tree.
> so I figured there was plenty of time to 
> get things fixed up - best to get it all flushed out and fix any fallout
> rather than hang around, given that UML seems to be still changing in
> fairly significant ways.
Ok, I had guessed we were near to the release instead.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

