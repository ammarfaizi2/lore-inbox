Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263134AbSJGQMc>; Mon, 7 Oct 2002 12:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263135AbSJGQMc>; Mon, 7 Oct 2002 12:12:32 -0400
Received: from bitmover.com ([192.132.92.2]:38059 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S263134AbSJGQMa>;
	Mon, 7 Oct 2002 12:12:30 -0400
Date: Mon, 7 Oct 2002 09:18:05 -0700
From: Larry McVoy <lm@bitmover.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, Rob Landley <landley@trommello.org>,
       linux-kernel@vger.kernel.org
Subject: Re: New BK License Problem?
Message-ID: <20021007091805.J14596@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rik van Riel <riel@conectiva.com.br>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
References: <20021007154303.GB20941@ravel.coda.cs.cmu.edu> <Pine.LNX.4.44L.0210071303180.22735-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44L.0210071303180.22735-100000@imladris.surriel.com>; from riel@conectiva.com.br on Mon, Oct 07, 2002 at 01:06:21PM -0300
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 01:06:21PM -0300, Rik van Riel wrote:
> On Mon, 7 Oct 2002, Jan Harkes wrote:
> 
> > I'm expecting that all the BK->gnu patch gateways will be shut down in
> > about 5 years,
> 
> I doubt that, the BK->patch "gateway" is a necessary part of
> kernel development.  Without it, bitkeeper would stop being
> useful.

Right.  It always was and always will be a feature that it is easy to
get in and get *out* of BK.  We may be pains in the butt on the license
front but once you are using BK, if you have to get the data out, BK
makes that as pleasant as can possibly be made.  See the export and prs
man pages for a starter.  It's policy that *every* item of metadata is
accessible via prs.

> I could be wrong, but I'm under the impression that Larry
> doesn't want others to just copy bitkeeper to come up with a
> free tool almost as good as bitkeeper.  There is no vendor
> lock-in or anything else going on, afaics.

Exactly right.  It wouldn't be so bad if someone were to clone it and come
up with a business model so that they could continue to develop it at the
same or better rate that we develop BK.  My real fear is that someone
will do a "good enough" clone to get around the license issues and it
won't be as good as BK and it won't continue get better like BK does.
That would be a "lowering of the bar" in terms of how good is good.
BK has raised the bar for what you should expect from a SCM system and
we're not done.  My take is that BK is at the "barely useable" stage, not
remotely close to being perfect.  We want to make it perfect.  We won't
get there because my definition of perfect means that no operation takes
more than 250 milliseconds and that's pretty impossible if you want to
do any I/O but we keep trying.  bk-3.0 is definitely faster and we have
some more perf changes in the queue.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
