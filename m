Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbSJHIPj>; Tue, 8 Oct 2002 04:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261331AbSJHIPj>; Tue, 8 Oct 2002 04:15:39 -0400
Received: from bohnice.netroute.lam.cz ([212.71.169.62]:53752 "EHLO
	vagabond.cybernet.cz") by vger.kernel.org with ESMTP
	id <S261206AbSJHIPi>; Tue, 8 Oct 2002 04:15:38 -0400
Date: Tue, 8 Oct 2002 10:19:38 +0200
From: Jan Hudec <bulb@ucw.cz>
To: Daniel Phillips <phillips@arcor.de>
Cc: Jesse Pollard <pollard@admin.navo.hpc.mil>,
       Rob Landley <landley@trommello.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Message-ID: <20021008081938.GA20784@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>,
	Daniel Phillips <phillips@arcor.de>,
	Jesse Pollard <pollard@admin.navo.hpc.mil>,
	Rob Landley <landley@trommello.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0210041610220.2465-100000@home.transmeta.com> <200210060130.g961UjY2206214@pimout2-ext.prodigy.net> <200210070856.07356.pollard@admin.navo.hpc.mil> <E17ycWf-0003u4-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E17ycWf-0003u4-00@starship>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 08:22:41PM +0200, Daniel Phillips wrote:
> On Monday 07 October 2002 15:56, Jesse Pollard wrote:
> > [the mouse] will still stall everytime the mouse crosses the window border IF the
> > application has specified "enter/leave" event notification. This requires the
> > application to be swapped in to recieve the event. The only fix is locking
> > the application/X libraries into memory.
> 
> That one could be punted with an hourglass cursor, until the events start flowing.
> Well.  Not sure how much this has to do with the kernel...

Nothing. It's X. And it will take another X protocol extension (so it
will suck yet more).

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
