Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269032AbTCAVPW>; Sat, 1 Mar 2003 16:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269033AbTCAVPW>; Sat, 1 Mar 2003 16:15:22 -0500
Received: from pdbn-d9bb8750.pool.mediaWays.net ([217.187.135.80]:16 "EHLO
	citd.de") by vger.kernel.org with ESMTP id <S269032AbTCAVPW>;
	Sat, 1 Mar 2003 16:15:22 -0500
Date: Sat, 1 Mar 2003 22:25:37 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: Dan Kegel <dank@kegel.com>
Cc: Joe Perches <joe@perches.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, mike@aiinc.ca
Subject: Re: [PATCH] kernel source spellchecker
Message-ID: <20030301212537.GA32408@citd.de>
References: <Pine.LNX.4.44.0303012026410.31670-101000@korben.citd.de> <3E612561.1050002@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E612561.1050002@kegel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 01, 2003 at 01:25:53PM -0800, Dan Kegel wrote:
> Matthias Schniedermeyer wrote:
> >This versions defaults to only correct words within a comment. ...
> >// Comments are easy(tm). "Everything after // until line-end".
> >
> >and /* ... */ are easy(tm) too because gcc doesn't support to nest them.
> 
> I'll be damned.  I'm impressed with how easy that was in perl.

As long as there is no nesting involved most things a easy/trivial to
achieve with REs.




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

