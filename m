Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267319AbTBPSMi>; Sun, 16 Feb 2003 13:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267320AbTBPSMi>; Sun, 16 Feb 2003 13:12:38 -0500
Received: from crack.them.org ([65.125.64.184]:44475 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S267319AbTBPSMh>;
	Sun, 16 Feb 2003 13:12:37 -0500
Date: Sun, 16 Feb 2003 13:21:52 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: John Levon <levon@movementarian.org>
Cc: Rahul Vaidya <rahulv@csa.iisc.ernet.in>,
       Zwane Mwaikambo <zwane@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.53 not compiling
Message-ID: <20030216182152.GA4861@nevyn.them.org>
Mail-Followup-To: John Levon <levon@movementarian.org>,
	Rahul Vaidya <rahulv@csa.iisc.ernet.in>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.50.0302161205240.578-100000@montezuma.mastecende.com> <Pine.SOL.3.96.1030216225625.25827E-100000@osiris.csa.iisc.ernet.in> <20030216174118.GA63890@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030216174118.GA63890@compsoc.man.ac.uk>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 05:41:18PM +0000, John Levon wrote:
> On Sun, Feb 16, 2003 at 10:57:50PM +0530, Rahul Vaidya wrote:
> 
> > I am getting the same error even for 2.5.61
> > 
> > Please cc any replies to rahulv@csa.iisc.ernet.in
> 
> Have you made a softlink for gcc ? Apparently that doesn't work well
> with recent gcc versions finding the headers...

That bug only exists in GCCs about a week old, it didn't matter to 3.2.
It can cause quirkiness, though.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
