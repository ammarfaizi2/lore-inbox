Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266122AbSL3Den>; Sun, 29 Dec 2002 22:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbSL3Den>; Sun, 29 Dec 2002 22:34:43 -0500
Received: from bitmover.com ([192.132.92.2]:4760 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S266122AbSL3Dem>;
	Sun, 29 Dec 2002 22:34:42 -0500
Date: Sun, 29 Dec 2002 19:43:03 -0800
From: Larry McVoy <lm@bitmover.com>
To: Russ Allbery <rra@stanford.edu>
Cc: Felix Domke <tmbinc@elitedvb.net>, linux-kernel@vger.kernel.org
Subject: Re: Indention - why spaces?
Message-ID: <20021230034303.GA11425@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Russ Allbery <rra@stanford.edu>, Felix Domke <tmbinc@elitedvb.net>,
	linux-kernel@vger.kernel.org
References: <fa.f9m4suv.e6ubgf@ifi.uio.no> <ylfzsgi3jz.fsf@windlord.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ylfzsgi3jz.fsf@windlord.stanford.edu>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 29, 2002 at 07:33:20PM -0800, Russ Allbery wrote:
> Felix Domke <tmbinc@elitedvb.net> writes:
> 
> > i don't want to change anything, i just like to know WHY people use
> > spaces. are they somehow unportable? (i don't think so)
> 
> <http://www.jwz.org/doc/tabs-vs-spaces.html>

Quouting from that page:
    That ensures that, even if I happened to insert a literal tab in the
    file by hand (or if someone else did when editing this file earlier),
    those tabs get expanded to spaces when I save. 

If you are using a source management system, pretty much *any* source
management system, doing this will cause all the lines to be "rewritten"
if they had tabs.  The fact that this person would advocate changing
code that they didn't actually change shows a distinct lack of clue.
No engineer who works for an even semi-pro company would dream of doing
this.  At BitMover, anyone who seriously advocated this for more than
a day would be fired.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
