Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129026AbRBGDZP>; Tue, 6 Feb 2001 22:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129416AbRBGDZG>; Tue, 6 Feb 2001 22:25:06 -0500
Received: from ns2.arlut.utexas.edu ([129.116.174.1]:26116 "EHLO
	ns2.arlut.utexas.edu") by vger.kernel.org with ESMTP
	id <S129119AbRBGDYk>; Tue, 6 Feb 2001 22:24:40 -0500
From: Jonathan Abbey <jonabbey@arlut.utexas.edu>
Message-Id: <200102070324.VAA16252@csdsun1.arlut.utexas.edu>
Subject: Re: Hard system freeze in 2.2.17, 2.2.18, 2.4.1-AC3 VIA Athlon
To: jonabbey@arlut.utexas.edu (Jonathan Abbey)
Date: Tue, 6 Feb 2001 21:24:29 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200102070107.TAA13197@csdsun1.arlut.utexas.edu> from "Jonathan Abbey" at Feb 6, 2001 07:07:32 pm
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Hahn wrote me and convinced me that the problem I described is a
hardware problem, probably related to heat.  

Testing bears this out.

I am still mystified as to why xemacs in particular should stress the
system more than everything else, but I've got the sanity check I was
looking for, and will treat it as a hardware problem from here on
out.

| I am having terribly frustrating system stability problems, and I
| can't figure out whether I should suspect hardware or the kernel.

-------------------------------------------------------------------------------
Jonathan Abbey 				              jonabbey@arlut.utexas.edu
Applied Research Laboratories                 The University of Texas at Austin
Ganymede, a GPL'ed metadirectory for UNIX     http://www.arlut.utexas.edu/gash2
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
