Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946104AbWBCXxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946104AbWBCXxG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 18:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946005AbWBCXxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 18:53:06 -0500
Received: from beauty.rexursive.com ([218.214.6.102]:38585 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S1030254AbWBCXxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 18:53:05 -0500
Subject: Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.
From: Bojan Smojver <bojan@rexursive.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Suspend2 Devel List <suspend2-devel@lists.suspend2.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200602031254.37335.rjw@sisk.pl>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>
	 <200602031018.35669.rjw@sisk.pl>
	 <1138962557.18190.18.camel@coyote.rexursive.com>
	 <200602031254.37335.rjw@sisk.pl>
Content-Type: text/plain
Date: Sat, 04 Feb 2006 10:53:01 +1100
Message-Id: <1139010781.2191.21.camel@coyote.rexursive.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 (2.5.90-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-03 at 12:54 +0100, Rafael J. Wysocki wrote:

> Well, unfortunately this is one of the problems I cannot solve.  This should
> really be reported to LKML as the ATI AGP driver problem or directly to the
> developers of this particular driver.  I can submit a bug report based on
> the inormation from you, though.
> 
> [swsusp uses whatever is in the drivers, so driver problems need to be
> fixed by their developers.]

This is exactly the point that I'm trying to make (and Nigel hinted
something along these lines). These problems have obviously been solved
in suspend2 (and I've got a machine to show it). Solutions are right
there. But for some reason, we are back to the drawing board.

I suggest you guys ask Nigel as to what he changed to make this work. I
don't think he just put the code there at random.

Look, I know I'm going to get blamed here for all kinds of things, from
starting a flame war to being incompetent because I'm not a kernel
hacker. That's cool. All I know is that somehow, somewhere, there are
chunks of code in suspend2 that make things work. If I didn't know
better, I would say it must be by magic :-)

-- 
Bojan

