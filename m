Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288936AbSAYBF1>; Thu, 24 Jan 2002 20:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290472AbSAYBFS>; Thu, 24 Jan 2002 20:05:18 -0500
Received: from amethyst.es.usyd.edu.au ([129.78.124.28]:29640 "EHLO
	amethyst.es.usyd.edu.au") by vger.kernel.org with ESMTP
	id <S290470AbSAYBFN>; Thu, 24 Jan 2002 20:05:13 -0500
Date: Fri, 25 Jan 2002 12:05:10 +1100 (EST)
From: ivan <ivan@es.usyd.edu.au>
To: <linux-kernel@vger.kernel.org>
Subject: Physical memory versus detected memory 2.4.7-10
Message-ID: <Pine.LNX.4.33.0201251110180.31632-100000@dipole.es.usyd.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear list users.

My server detects less memory than it available. 

	Available memory according to the BIOS 4049MB.

	System sees only 3.7GB ???
	Mem:  3799580K av, 1606816K used, 2192764K free, 468K shrd, 376972K buff
	Swap: 8192992K av, 0K used, 8192992K free 1037532K cached


OS RedHat 2.7 standard kernel.
	Linux atlas.es.usyd.edu.au 2.4.7-10smp #1 SMP Mon Dec 10 13:08:57 EST 2001 i686 unknown

Hardware PowerEdge 4400. 
	( supports 4GB )

Additional problem:  
	random crushes, trying to to find out why.

Questions : 	1) Any comments on why top only shows 3.7 Gb are welcome.


Thank you.
================================================================================

Ivan Teliatnikov,
F05 David Edgeworth Building,
Department of Geology and Geophysics,
School of Geosciences,
University of Sydney, 2006
Australia

e-mail: ivan@es.usyd.edu.au
ph:  061-2-9351-2031 (w)
fax: 061-2-9351-0184 (w)

===============================================================================


