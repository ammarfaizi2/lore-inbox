Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751736AbWI1Har@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736AbWI1Har (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 03:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751735AbWI1Haq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 03:30:46 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54958 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751736AbWI1Hap
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 03:30:45 -0400
Date: Thu, 28 Sep 2006 08:30:29 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Sergey Panov <sipan@sipan.org>
Cc: Jeff Garzik <jeff@garzik.org>, Chase Venters <chase.venters@clientec.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Patrick McFarland <diablod3@gmail.com>, Theodore Tso <tytso@mit.edu>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
Message-ID: <20060928073029.GW29920@ftp.linux.org.uk>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com> <Pine.LNX.4.64.0609271945450.3952@g5.osdl.org> <1159415242.13562.12.camel@sipan.sipan.org> <200609272339.28337.chase.venters@clientec.com> <451B5A59.9040806@garzik.org> <1159421223.13562.75.camel@sipan.sipan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159421223.13562.75.camel@sipan.sipan.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 01:27:03AM -0400, Sergey Panov wrote:
> On Thu, 2006-09-28 at 01:15 -0400, Jeff Garzik wrote:
> > Chase Venters wrote:
> > > I sympathize with Richard on his avoidance of "open-source". I don't 
> > > necessarily take the same view, but I understand that his big concern is that 
> > > the message he feels is important will be lost. I also think some of the 
> > > things I've heard from the "open-source" side are too extreme - take, for 
> > > instance, ESR's idea that we don't need the GPL license at all. That sounds 
> > > like a nice world he's living in, but I'm not sure we're all on the same 
> > > planet yet.
> > 
> > ESR is a nutcase too.
> 
>  How did you manage to figure it out?

Well, you tell me...  What would you say about the following kind of paper:
	* it is generally assumed that conditions X, Y and Z are needed
to get the result with property P.
	* in experiment [ref] P had been obtained despite the lack of all
aforementioned conditions.
	* author will attempt to formulate the conditions sufficient to achieve
P, explaining the results of said experiment.
	* hypothetical conditions described, their applicability to experiment
in question discussed.
	* author has attempted to test his hypothetis.
	* description of experiment, strongly implying that P has been
achieved as the result.
	* conclusions.

The trouble being, results of experiment are available and P is profoundly
_not_ observed.  Moreover, if you start looking at the description in the
paper, you find a serious misdirection; what it really shows is P', which
is considerably weaker than P.  The differences are systematically glossed
over; experiment declared a success despite being a definite proof that stated
conditions are _NOT_ sufficient.  Conclusions would be highly speculative
even if experiment had been successful.  No discussion of alternative
explanations for the original results is to be found anywhere in the paper.
Paper is widely published on the web and is used for self-promotion worthy
of Prof. Vybegallo.

That's ESR for you.  The paper in qustion is "The Cathedral and the Bazaar".
P is "coherent and stable system".  ESR's experiment: fetchmail.  Source
of that animal (and paper itself) are easily found.  Have fun.
