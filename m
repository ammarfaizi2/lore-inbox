Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262658AbREVRDz>; Tue, 22 May 2001 13:03:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262665AbREVRDp>; Tue, 22 May 2001 13:03:45 -0400
Received: from mail.zmailer.org ([194.252.70.162]:31247 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S262653AbREVRDe>;
	Tue, 22 May 2001 13:03:34 -0400
Date: Tue, 22 May 2001 20:03:20 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Tony Hoyle <tmh@magenta-netlogic.com>,
        "Brent D. Norris" <brent@biglinux.tccw.wku.edu>,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-hams@vger.kernel.org, linux-ppp@vger.kernel.org
Subject: Re: ECN is on!
Message-ID: <20010522200320.O5947@mea-ext.zmailer.org>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <15114.18990.597124.656559@pizda.ninka.net> <Pine.LNX.4.30.0105220649530.17291-100000@biglinux.tccw.wku.edu> <200105221306.f4MD6Pi00360@mobilix.ras.ucalgary.ca> <3B0A8D16.2050400@magenta-netlogic.com> <200105221623.f4MGNTa02164@mobilix.atnf.CSIRO.AU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200105221623.f4MGNTa02164@mobilix.atnf.CSIRO.AU>; from rgooch@ras.ucalgary.ca on Tue, May 22, 2001 at 12:23:29PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  FOLKS, I HAVE ALL THE TIME USED 'Reply-To:' HEADER POINTING
  TO  linux-kernel -- INSTEAD OF ALL THE LISTS...

  If you want to continue this, do it there.
  (Before I decide to taboo "Re: ECN is on!" subject line..)


On Tue, May 22, 2001 at 12:23:29PM -0400, Richard Gooch wrote:
...
> Well, while that would be somewhat satisfying, there is a problem if
> the message gets corrupted by this. And since some people send to the
> list without being subscribed (or, like me, have duplicate filtering),
> they'll never see that their message was mangled as it passed through
> the list.
> 
> Nope, a bounce is better. If you're going to do these things, feedback
> is essential. The bounce isn't meant to offend the sender, it's
> designed to let them know what's happening.

	The only GOOD time to bounce is at SMTP reception
	into VGER, not latter.  It doesn't have facilities
	to do all what Majordomo taboo filters do now.
	(Just because I have been lazy and haven't done
	 any such content filters for vger.)

	With ECN on, emailed bounce messages won't (necessarily)
	make it to the sender at all.

	Majordomo's filter bounces the message to be approved
	by list owner -- who usually uses the 'D' key to my
	knowledge.

> 				Regards,
> 
> 					Richard....
> Permanent: rgooch@atnf.csiro.au
> Current:   rgooch@ras.ucalgary.ca

/Matti Aarnio
