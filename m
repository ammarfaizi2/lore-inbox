Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268055AbTBWHvg>; Sun, 23 Feb 2003 02:51:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268056AbTBWHvg>; Sun, 23 Feb 2003 02:51:36 -0500
Received: from bitmover.com ([192.132.92.2]:59058 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S268055AbTBWHvf>;
	Sun, 23 Feb 2003 02:51:35 -0500
Date: Sun, 23 Feb 2003 00:01:43 -0800
From: Larry McVoy <lm@bitmover.com>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Larry McVoy <lm@bitmover.com>, William Lee Irwin III <wli@holomorphy.com>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030223080142.GC11953@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Gerrit Huizenga <gh@us.ibm.com>, Larry McVoy <lm@bitmover.com>,
	William Lee Irwin III <wli@holomorphy.com>,
	Mark Hahn <hahn@physics.mcmaster.ca>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <20030222232859.GC31268@work.bitmover.com> <E18mjhj-0004x6-00@w-gerrit2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E18mjhj-0004x6-00@w-gerrit2>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 04:09:15PM -0800, Gerrit Huizenga wrote:
> On Sat, 22 Feb 2003 15:28:59 PST, Larry McVoy wrote:
> > On Sat, Feb 22, 2003 at 02:17:39PM -0800, William Lee Irwin III wrote:
> > > On Sat, Feb 22, 2003 at 05:06:27PM -0500, Mark Hahn wrote:
> > > > ccNUMA worst-case latencies are not much different from decent 
> > > > cluster (message-passing) latencies.
> > > 
> > > Not even close, by several orders of magnitude.
> > 
> > Err, I think you're wrong.  It's been a long time since I looked, but I'm
> > pretty sure myrinet had single digit microseconds.  Yup, google rocks,
> > 7.6 usecs, user to user.  Last I checked, Sequents worst case was around
> > there, right?
> 
> You are going to drag 1994 technology into this to compare against
> something in 2003?  Hmm.  You might win on that comparison.  But yeah,
> Sequent way back then was in that ballpark.  World has moved forwards
> since then...

Really?  "Several orders of magnitude"?  Show me the data.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
