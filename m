Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S160479AbQG1Nyk>; Fri, 28 Jul 2000 09:54:40 -0400
Received: by vger.rutgers.edu id <S160458AbQG1NyQ>; Fri, 28 Jul 2000 09:54:16 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:2521 "EHLO smtp1.cern.ch") by vger.rutgers.edu with ESMTP id <S160450AbQG1Nw5>; Fri, 28 Jul 2000 09:52:57 -0400
Date: Fri, 28 Jul 2000 16:11:55 +0200
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Cc: alan@lxorguk.ukuu.org.uk, "Theodore Y. Ts'o" <tytso@MIT.EDU>, Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.rutgers.edu
Subject: Re: RLIM_INFINITY inconsistency between archs
Message-ID: <20000728161155.A4813@pcep-jamie.cern.ch>
References: <E13HsBT-00033e-00@the-village.bc.nu> <200007281405.JAA101655@tomcat.admin.navo.hpc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200007281405.JAA101655@tomcat.admin.navo.hpc.mil>; from pollard@tomcat.admin.navo.hpc.mil on Fri, Jul 28, 2000 at 09:05:27AM -0500
Sender: owner-linux-kernel@vger.rutgers.edu

Jesse Pollard wrote:
> > 	/lib/modules/2.2.14/build
> 
> Just an additional thought..
> 
> How about being able to set the link at boot time too - this is for those
> sites that have multiple kernels installed (for instance: old reliable,
> current reliable, and test). Then each kernel could use different modules
> selected at boot time.

That's what the "2.2.14" is for.  Whatever mechanism you use to select
version-dependent modules at boot time, you use that to find the
appropriate "build" link too.

-- Jamie

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
