Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267310AbTBPSB1>; Sun, 16 Feb 2003 13:01:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267312AbTBPSB1>; Sun, 16 Feb 2003 13:01:27 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:12673 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S267310AbTBPSBZ>;
	Sun, 16 Feb 2003 13:01:25 -0500
Date: Sun, 16 Feb 2003 23:41:13 +0530 (IST)
From: Rahul Vaidya <rahulv@csa.iisc.ernet.in>
To: Russell King <rmk@arm.linux.org.uk>
Cc: John Levon <levon@movementarian.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.53 not compiling
In-Reply-To: <20030216174637.C12489@flint.arm.linux.org.uk>
Message-ID: <Pine.SOL.3.96.1030216234035.25827G-100000@osiris.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any way (for me) to change the configurations of gcc?


On Sun, 16 Feb 2003, Russell King wrote:

> On Sun, Feb 16, 2003 at 05:41:18PM +0000, John Levon wrote:
> > On Sun, Feb 16, 2003 at 10:57:50PM +0530, Rahul Vaidya wrote:
> > 
> > > I am getting the same error even for 2.5.61
> > > 
> > > Please cc any replies to rahulv@csa.iisc.ernet.in
> > 
> > Have you made a softlink for gcc ? Apparently that doesn't work well
> > with recent gcc versions finding the headers...
> 
> It looks like buggy gcc configuration scripts - some parts of the compiler
> seems to believe its internal headers are one place, whereas other parts
> believe they're elsewhere.
> 
> -- 
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html
> 
> 

