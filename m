Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292020AbSBAUx6>; Fri, 1 Feb 2002 15:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292018AbSBAUxf>; Fri, 1 Feb 2002 15:53:35 -0500
Received: from rakis.net ([207.8.143.12]:7842 "EHLO egg.rakis.net")
	by vger.kernel.org with ESMTP id <S292015AbSBAUx3>;
	Fri, 1 Feb 2002 15:53:29 -0500
Date: Fri, 1 Feb 2002 15:53:28 -0500 (EST)
From: Greg Boyce <gboyce@rakis.net>
X-X-Sender: gboyce@egg
To: gmack@innerfire.net
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Machines misreporting Bogomips 
In-Reply-To: <Pine.LNX.4.21.0202011258150.12383-100000@innerfire.net>
Message-ID: <Pine.LNX.4.42.0202011549090.5498-100000@egg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The machine is actually slower.  That's how I noticed the problem.
> >
> > Underclocking dosen't seem likely due to the difference in speed.  It's 4
> > bogomips instead of 500.  The machine is running at about the speed of a
> > 386 (I believe that's about right).  It almost seems as if someone turned
> > off the turbo button.  But of course I haven't seen one of those since my
> > old 486 :)
> >
> > --
> > Greg Boyce
> >
> >
>
> Could they be running with cache disabled in the bios?
>

The machine is reporting that the cache is enabled.  Even if this was
true, I have trouble believing that turning on the cache would result in a
50,000% increase in speed (4 bogomips compared to 500).

I have a feeling that I'm going to have to chalk this one up to hardware
failure.  Another kind soul suggested it could be ECC memory reporting a
continual string of 1 bit failures.

--
Greg Boyce



