Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267980AbTBWAAE>; Sat, 22 Feb 2003 19:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267985AbTBWAAE>; Sat, 22 Feb 2003 19:00:04 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14538 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267980AbTBWAAD>;
	Sat, 22 Feb 2003 19:00:03 -0500
To: Larry McVoy <lm@bitmover.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Minutes from Feb 21 LSE Call 
In-reply-to: Your message of Sat, 22 Feb 2003 15:28:59 PST.
             <20030222232859.GC31268@work.bitmover.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19036.1045958955.1@us.ibm.com>
Date: Sat, 22 Feb 2003 16:09:15 -0800
Message-Id: <E18mjhj-0004x6-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2003 15:28:59 PST, Larry McVoy wrote:
> On Sat, Feb 22, 2003 at 02:17:39PM -0800, William Lee Irwin III wrote:
> > On Sat, Feb 22, 2003 at 05:06:27PM -0500, Mark Hahn wrote:
> > > ccNUMA worst-case latencies are not much different from decent 
> > > cluster (message-passing) latencies.
> > 
> > Not even close, by several orders of magnitude.
> 
> Err, I think you're wrong.  It's been a long time since I looked, but I'm
> pretty sure myrinet had single digit microseconds.  Yup, google rocks,
> 7.6 usecs, user to user.  Last I checked, Sequents worst case was around
> there, right?

You are going to drag 1994 technology into this to compare against
something in 2003?  Hmm.  You might win on that comparison.  But yeah,
Sequent way back then was in that ballpark.  World has moved forwards
since then...

gerrit
