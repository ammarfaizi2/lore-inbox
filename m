Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317315AbSGTBtZ>; Fri, 19 Jul 2002 21:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317312AbSGTBtZ>; Fri, 19 Jul 2002 21:49:25 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:3341 "EHLO probity.mcc.ac.uk")
	by vger.kernel.org with ESMTP id <S317308AbSGTBtZ>;
	Fri, 19 Jul 2002 21:49:25 -0400
Date: Sat, 20 Jul 2002 02:52:16 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild - building a module/target from multiple directories
Message-ID: <20020720015215.GA43258@compsoc.man.ac.uk>
References: <20020720002521.GA34954@compsoc.man.ac.uk> <Pine.LNX.4.44.0207192019230.1639-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0207192019230.1639-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Boards of Canada - Geogaddi
X-Scanner: exiscan *17VjPx-000B99-00*Kj1Q6FHH.0U* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2002 at 08:23:36PM -0500, Kai Germaschewski wrote:

> > With kbuild in 2.5, how do I specify that a module/target is to be built of
> > object files and sub-directories ?
> 
> Short answer: Don't.

Why not ? Simply because kbuild can't handle it nicely ?

> 	blah-objs := blah_init.o blahstuff/blah1.o blahstuff/blah2.o ...

Hmmm, that "works" I suppose

thanks
john

-- 
"Of all manifestations of power, restraint impresses the most."
	- Thucydides
