Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVGZCbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVGZCbi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 22:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVGZCbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 22:31:38 -0400
Received: from chretien.genwebhost.com ([209.59.175.22]:21716 "EHLO
	chretien.genwebhost.com") by vger.kernel.org with ESMTP
	id S261585AbVGZCbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 22:31:36 -0400
Date: Mon, 25 Jul 2005 19:31:24 -0700
From: randy_dunlap <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: miles@gnu.org, miles@lsi.nec.co.jp, torvalds@osdl.org,
       76306.1226@compuserve.com, linux-kernel@vger.kernel.org,
       vincent.hanquez@cl.cam.ac.uk, ak@suse.de
Subject: Re: [patch 2.6.13-rc3] i386: clean up user_mode macros
Message-Id: <20050725193124.79dbcb10.rdunlap@xenotime.net>
In-Reply-To: <20050725183413.08ed2a5f.akpm@osdl.org>
References: <200507251901_MC3-1-A589-A433@compuserve.com>
	<Pine.LNX.4.58.0507251608430.6074@g5.osdl.org>
	<buoll3upd84.fsf@mctpc71.ucom.lsi.nec.co.jp>
	<20050725183413.08ed2a5f.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClamAntiVirus-Scanner: This mail is clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - chretien.genwebhost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - xenotime.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jul 2005 18:34:13 -0700 Andrew Morton wrote:

> Miles Bader <miles@lsi.nec.co.jp> wrote:
> >
> > Linus Torvalds <torvalds@osdl.org> writes:
> >  > Ask a hundred random C programmers what "!!x" means, versus what "x != 0"
> >  > means, and time their replies.
> > 
> >  I've always thought of "!!" as the "canonicalize boolean" operator...
> 
> Me too.  Once you get used to it, it's just the "convert non-zero to 1"
> operator.
> 
> But whatever.

I call it "truth value" (true or false), but once I got used to it,
I thought it was OK too.

---
~Randy
