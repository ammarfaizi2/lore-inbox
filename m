Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293289AbSCJVib>; Sun, 10 Mar 2002 16:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293291AbSCJViX>; Sun, 10 Mar 2002 16:38:23 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:25264 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S293289AbSCJViJ>; Sun, 10 Mar 2002 16:38:09 -0500
Date: Sun, 10 Mar 2002 14:37:59 -0700
Message-Id: <200203102137.g2ALbxM21504@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Hans Reiser <reiser@namesys.com>
Cc: Itai Nahshon <itai@siftology.com>, Larry McVoy <lm@bitmover.com>,
        Tom Lord <lord@regexps.com>, jaharkes@cs.cmu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <3C8BBFCF.5010504@namesys.com>
In-Reply-To: <Pine.LNX.4.44.0202052328470.32146-100000@ash.penguinppc.org>
	<20020207132558.D27932@work.bitmover.com>
	<3C8B1B25.7000208@namesys.com>
	<200203101941.g2AJfSD19756@lmail.actcom.co.il>
	<3C8BBFCF.5010504@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser writes:
> Itai Nahshon wrote:
> 
> >On Sunday 10 March 2002 10:36, Hans Reiser wrote:
> >
> >>I think that if version control becomes as simple as turning on a plugin
> >>for a directory or file, and then adding a little to the end of a
> >>filename to see and list the old versions, Mom can use it.
> >>
> >
> >IIRC that was a feature in systems from DEC even before
> >VMS (I'm talking about the late 70's).  eg. file.txt;2 was revision 2
> >of file.txt.
> >
> 
> Was it easy?  Did people like it?  Any lessons/successes?

Mostly I found it an inconvenience. When playing with big files (say
around 1 MiB), you had to remember to purge periodically. I can't
recall being grateful that this feature existed.

Certainly, when I switched to Unix, I didn't miss file versioning.
I question how useful it really is, except in certain specialised
applications (like SCM, where we have tools to fit the job).

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
