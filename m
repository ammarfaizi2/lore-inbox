Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314258AbSDVQKW>; Mon, 22 Apr 2002 12:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314260AbSDVQKV>; Mon, 22 Apr 2002 12:10:21 -0400
Received: from bitmover.com ([192.132.92.2]:36518 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S314258AbSDVQKN>;
	Mon, 22 Apr 2002 12:10:13 -0400
Date: Mon, 22 Apr 2002 09:10:12 -0700
From: Larry McVoy <lm@bitmover.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Larry McVoy <lm@bitmover.com>, Linus Torvalds <torvalds@transmeta.com>,
        Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org
Subject: Re: BK, deltas, snapshots and fate of -pre...
Message-ID: <20020422091012.C17613@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Larry McVoy <lm@bitmover.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Ian Molton <spyro@armlinux.org>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204202108410.10137-100000@home.transmeta.com> <E16zGq9-0001EW-00@starship> <20020422084421.A17613@work.bitmover.com> <E16zJbd-0001GZ-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 05:50:25PM +0200, Daniel Phillips wrote:
> > The existence (or non-existence) of the docs has absolutely no marketing
> > value to BK.
> 
> So you have no problem with moving them to a website, leaving a url in
> SubmittingPatches?

It's not my call to make.  Take it up with the people who own the tree.

Personally, I think a patch like this is more of what you need:

===== bk-kernel-howto.txt 1.2 vs edited =====
--- 1.2/Documentation/BK-usage/bk-kernel-howto.txt      Fri Mar 15 09:08:54 2002
+++ edited/bk-kernel-howto.txt  Mon Apr 22 09:04:26 2002
@@ -1,5 +1,9 @@
+To placate some pedantic people who feel that this document is an
+advertisement, the name of the source management system has been
+replaced with "groovy SCM".
 
-                  Doing the BK Thing, Penguin-Style
+
+                  Doing the groovy SCM Thing, Penguin-Style
 
 
 
@@ -11,48 +15,48 @@
 Due to the author's background, an operation may be described in terms
 of CVS, or in terms of how that operation differs from CVS.
 
-This is -not- intended to be BitKeeper documentation.  Always run
+This is -not- intended to be groovy SCM documentation.  Always run
 "bk help <command>" or in X "bk helptool <command>" for reference
 documentation.
 
 
-BitKeeper Concepts
-------------------
+groovy SCM Concepts
+-------------------

etc.

-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
