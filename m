Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVDJX1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVDJX1l (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVDJX0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:26:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:33179 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261648AbVDJXZJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:25:09 -0400
Date: Sun, 10 Apr 2005 16:23:11 -0700
From: Paul Jackson <pj@engr.sgi.com>
To: Petr Baudis <pasky@ucw.cz>
Cc: torvalds@osdl.org, mingo@elte.hu, willy@w.ods.org,
       linux-kernel@vger.kernel.org, rddunlap@osdl.org, ross@jose.lug.udel.edu
Subject: Re: [ANNOUNCE] git-pasky-0.1
Message-Id: <20050410162311.0c6da79c.pj@engr.sgi.com>
In-Reply-To: <20050410222737.GC5902@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org>
	<Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org>
	<Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org>
	<20050410024157.GE3451@pasky.ji.cz>
	<20050410162723.GC26537@pasky.ji.cz>
	<20050410173349.GA17549@elte.hu>
	<20050410174221.GD7858@alpha.home.local>
	<20050410174512.GA18768@elte.hu>
	<20050410184522.GA5902@pasky.ji.cz>
	<Pine.LNX.4.58.0504101310430.1267@ppc970.osdl.org>
	<20050410222737.GC5902@pasky.ji.cz>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr wrote:
> That reminds me, is there any
> tool which will take .rej files and throw them into the file to create
> rcsmerge-like conflicts?

  Check out 'wiggle'
    http://www.cse.unsw.edu.au/~neilb/source/wiggle/

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
