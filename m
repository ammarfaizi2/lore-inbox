Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264725AbUEaSjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264725AbUEaSjk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 14:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264731AbUEaSjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 14:39:40 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:14614 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S264725AbUEaSjj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 14:39:39 -0400
Date: Mon, 31 May 2004 20:42:18 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Bjorn Wesen <bjorn.wesen@axis.com>
Cc: Dan Kegel <dank@kegel.com>, Mikael Starvik <mikael.starvik@axis.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Delete cris architecture?
Message-ID: <20040531184218.GA2101@mars.ravnborg.org>
Mail-Followup-To: Bjorn Wesen <bjorn.wesen@axis.com>,
	Dan Kegel <dank@kegel.com>, Mikael Starvik <mikael.starvik@axis.com>,
	linux-kernel@vger.kernel.org
References: <40BB3751.6060200@kegel.com> <Pine.LNX.4.33.0405311807550.14955-100000@godzilla.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0405311807550.14955-100000@godzilla.se.axis.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2004 at 06:14:02PM +0200, Bjorn Wesen wrote:
> The CRIS architecture is stable and supported by Axis Communications 
> officially in 2.4, but the 2.6 port is work-in-progress, thus you could 
> expect problems building it from the vanilla kernel source. It works 
> in-house on 2.6, but perhaps all patches have not trickled out to the 
> official kernel yet (although they should have I think, so it's good that 
> you mention stuff like this).

When grepping the source and even doing cross architecture changes it is
nice to have a ratehr up-to-date version in the main stream kernel.

It would be nice if Axis could at least drop an update of the tree for
each kernel release (provided there are any changes).
This would allow all of us to get a better overview, and in some cases
we may even introduce new stuff / fix errors.

So please start to feed Andrew (or Linus) regularly with updates.

	Sam
