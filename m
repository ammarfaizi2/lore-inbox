Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269991AbUJWCNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269991AbUJWCNH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 22:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269983AbUJWCIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 22:08:17 -0400
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:40365 "EHLO
	clueserver.org") by vger.kernel.org with ESMTP id S269805AbUJWCFB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 22:05:01 -0400
Date: Fri, 22 Oct 2004 18:08:12 -0700 (PDT)
From: alan <alan@clueserver.org>
X-X-Sender: alan@www.fnordora.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, Matt Mackall <mpm@selenic.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
In-Reply-To: <Pine.LNX.4.58.0410221821030.2101@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.44.0410221807140.30372-100000@www.fnordora.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004, Linus Torvalds wrote:

> 
> 
> Hey guys, calm down, I meant "naming wars" in a silly kind of way, not the 
> nasty kind.
> 
> The fact is, Linux naming has always sucked. Well, at least the versioning 
> I've used. Others tend to be more organized. Me, I'm the "artistic" type, 
> so I sometimes try to do something new, and invariably stupid. 
> 
> The best suggestion so far has been to _just_ use another number, which
> makes sense considering my dislike for both -rc and -pre.
> 
> However, for some reason four numbers just looks visually too obnoxious to
> me, so as I don't care that much, I'll just use "-rc", and we can all
> agree that it stands for "Ridiculous Count" rather than "Release
> Candidate".
> 
> More importantly, maybe we could all realize that it isn't actually that 
> big of an issue ;)

Besides...  -pre and -rc additions do not sort correctly unless your sort 
routine has special cases to take care of it.


