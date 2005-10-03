Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932608AbVJCS4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbVJCS4m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbVJCS4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:56:41 -0400
Received: from free.hands.com ([83.142.228.128]:6110 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S932608AbVJCS4l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:56:41 -0400
Date: Mon, 3 Oct 2005 19:56:24 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: Meelis Roos <mroos@linux.ee>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051003185624.GA8548@lkcl.net>
References: <20051003004442.GL6290@lkcl.net> <20051003075000.28A8C13ED9@rhn.tartu-labor> <20051003180858.GA8011@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003180858.GA8011@csclub.uwaterloo.ca>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 02:08:58PM -0400, Lennart Sorensen wrote:
> On Mon, Oct 03, 2005 at 10:50:00AM +0300, Meelis Roos wrote:
> > LKCL>  the code for oskit has been available for some years, now,
> > LKCL>  and is regularly maintained.  the l4linux people have had to
> > 
> > My experience with oskit (trying to let students use it for OS course
> > homework) is quite ... underwhelming. It works as long as you try to use
> > it exactly like the developers did and breaks on a slightest sidestep
> > from that road. And there's not much documentation so it's hard to learn
> > where that road might be.

analysis, verification, debugging and adoption of oskit by
the linux kernel maintainers would help enormously there,
i believe, which is why i invited the kernel maintainers to
give it some thought.

there are other reasons: not least is that oskit _is_ the
linux kernel source code - with the kernel/* bits removed and
the device drivers and support infrastructure remaining.


so the developers who split the linux source code out into oskit did
not, in your opinion and experience, meelis, do a very good job: so
educate them and tell them how to do it better.

l.

