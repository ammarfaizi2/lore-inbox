Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S155945AbQEUQmS>; Sun, 21 May 2000 12:42:18 -0400
Received: by vger.rutgers.edu id <S155957AbQEUQl6>; Sun, 21 May 2000 12:41:58 -0400
Received: from gadolinium.btinternet.com ([194.73.73.111]:36606 "EHLO gadolinium") by vger.rutgers.edu with ESMTP id <S155279AbQEUQlm>; Sun, 21 May 2000 12:41:42 -0400
Date: Sun, 21 May 2000 17:47:11 +0100 (BST)
From: Dave Jones <dave@denial.force9.co.uk>
To: "Powertweak Linux announce list. -- Linux Kernel Mailing List" <linux-kernel@vger.rutgers.edu>, linux-perf@www-klinik.uni-mainz.de, powertweak-linux@powertweak.com
Subject: [ANNOUNCE] Powertweak-Linux v0.1.15
Message-ID: <Pine.LNX.4.21.0005211745450.1892-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu


Now available from http://linux.powertweak.com


v0.1.15 [Release 16. -- The 'Oops again' release ]

	Making a release with a bad head-cold wasn't a good idea.
	This release mostly fixes stuff that I screwed up on
	last time..


	More detailed changes this time include:
		o The PCI tuning now works again.
		  - Added workaround for gcc bug.
		  - Fixed problem with tweaks that wanted bits
		    set to 0.
		  - Inconsistencies in VIA VP3 tweak definitions fixed.
		o 'Kernel' & 'token-ring' /proc tuning options
		  [Alan Cox]
		o CDROM tweaking now works.
		o Annoying 'saving' debugging printf disabled.
		o Added RPM specs.
		  [Ryan Weaver]
		o autoconf/automake cleanups.
		  [Caolan McNamara, Arjan, myself]

	Note, that with this release, you now NEED the following..
	PCI Utilities (At least version 2.1.0)
	LibXML (At least version 1.8.0)

regards,

-- 
Dave.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
