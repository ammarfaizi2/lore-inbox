Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbSJJXnW>; Thu, 10 Oct 2002 19:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbSJJXnW>; Thu, 10 Oct 2002 19:43:22 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30980
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S262207AbSJJXnW>; Thu, 10 Oct 2002 19:43:22 -0400
Date: Thu, 10 Oct 2002 16:49:01 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Scott Mcdermott <vaxerdec@frontiernet.net>
Cc: linux-kernel@vger.kernel.org, Jan Hudec <bulb@ucw.cz>,
       Jesse Pollard <pollard@admin.navo.hpc.mil>,
       Oliver Neukum <oliver@neukum.name>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       "Martin J. Bligh" <fmbligh@aracnet.com>
Subject: Re: [OT] Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 - (NUMA))
Message-ID: <20021010234901.GD2673@matchmail.com>
Mail-Followup-To: Scott Mcdermott <vaxerdec@frontiernet.net>,
	linux-kernel@vger.kernel.org, Jan Hudec <bulb@ucw.cz>,
	Jesse Pollard <pollard@admin.navo.hpc.mil>,
	Oliver Neukum <oliver@neukum.name>,
	Helge Hafting <helgehaf@aitel.hist.no>,
	"Martin J. Bligh" <fmbligh@aracnet.com>
References: <m17yCIx-006hSwC@Mail.ZEDAT.FU-Berlin.DE> <m17yUp7-006fgcC@Mail.ZEDAT.FU-Berlin.DE> <20021007141122.GA14423@vagabond> <200210071001.22467.pollard@admin.navo.hpc.mil> <20021007153438.GA14993@vagabond> <20021007231204.C3029@newbox.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021007231204.C3029@newbox.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 07, 2002 at 11:12:04PM -0400, Scott Mcdermott wrote:
> Jan Hudec on Mon  7/10 17:34 +0200:
> > Well, depends on what we want to measure. If it's on the begining of
> > main, it measures library loading time. Then argument parsing, library
> > initialization, X initialization etc. can be measured. All those parts
> > should be timed so we can see where most time is spent and which can
> > be sped up.
> 
> newer glibc prelinking support should help here a lot, according to
> publshed time trials I have seen with and without the feature.

Define newer.

Latest 2.2, or upcoming 3.0?
