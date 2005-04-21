Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261361AbVDUNgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbVDUNgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 09:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbVDUNgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 09:36:06 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:41914 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261361AbVDUNfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 09:35:55 -0400
Date: Thu, 21 Apr 2005 09:35:54 -0400
To: Doug Ledford <dledford@redhat.com>
Cc: Dave Airlie <airlied@gmail.com>,
       Helge Hafting <helge.hafting@aitel.hist.no>,
       Chris Friesen <cfriesen@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: nVidia stuff again
Message-ID: <20050421133554.GU17865@csclub.uwaterloo.ca>
References: <1113341579.3105.63.camel@caveman.xisl.com> <425CEAC2.1050306@aitel.hist.no> <20050413125921.GN17865@csclub.uwaterloo.ca> <20050413130646.GF32354@marowsky-bree.de> <20050413132308.GP17865@csclub.uwaterloo.ca> <425D3924.1070809@nortel.com> <425E77BB.5010902@aitel.hist.no> <1114021024.26866.63.camel@compaq-rhel4.xsintricity.com> <21d7e997050420161234141e23@mail.gmail.com> <1114085702.26866.137.camel@compaq-rhel4.xsintricity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114085702.26866.137.camel@compaq-rhel4.xsintricity.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2005 at 08:15:02AM -0400, Doug Ledford wrote:
> Ha!  That's the whole damn point Dave.  Use your head.  Just because ATI
> is getting more complex with their GPU does *not* mean nVidia is.  Go
> back to my original example of the aic7xxx cards.  The alternative to
> their simple hardware design is something like the BusLogic or QLogic
> cards that are far more complex.  Your assuming that because the ATI
> cards are getting more complex and people are less able to discern their
> makeup just by reading the specs that the nVidia cards are doing the
> same, nVidia is telling you otherwise, and you are just blowing that off
> as though you know more about their cards than they do.  Reality is that
> they *could* be telling the truth and the fact that their card is a more
> simplistic card than ATIs may be the very reason that ATI has ponied up
> specs and they haven't.  Therefore, you can reliably discern absolutely
> *zero* information about the nVidia cards from a reference to ATI specs.

Certainly possible.  Maybe all their real IP is in the code, although if
that was true, letting opensource peope ahve the programing spec and
have to do their own drivers wouldn't expose that IP.  I have no idea.

> "It's what you know, not what you think you know, that matters."  I
> don't know why nVidia keeps their specs secret.  All I know is what they
> tell the world.  But what I do know is that it's *possible* they could
> be telling the truth, and I have no proof otherwise, regardless of any
> suspicions.

At least as far as I have understood things, the 3D hardware in the old
SGIs was very simple.  Lots and lots of multiple and add units which the
drivers then used in clever ways to implement fast 3D.  nvidia certainly
employs many ex-SGI people, so perhaps internally it is still based on
that idea, although I doubt it's quite that simple anymore.

Len Sorensen
