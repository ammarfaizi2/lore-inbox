Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261862AbSJVBdj>; Mon, 21 Oct 2002 21:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261863AbSJVBdj>; Mon, 21 Oct 2002 21:33:39 -0400
Received: from vitelus.com ([64.81.243.207]:7437 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S261862AbSJVBdg>;
	Mon, 21 Oct 2002 21:33:36 -0400
Date: Mon, 21 Oct 2002 18:39:28 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: thockin@sun.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
Message-ID: <20021022013928.GH25042@vitelus.com>
References: <200210220036.g9M0aP831358@scl2.sfbay.sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210220036.g9M0aP831358@scl2.sfbay.sun.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 05:36:25PM -0700, Timothy Hockin wrote:
> + * 3. All advertising materials mentioning features or use of this software
> + *    must display the following acknowledgement:
> + *	This product includes software developed by the University of
> + *	California, Berkeley and its contributors.

Ahem.

Since the copyright holder appears to be the Regents of the University
of California, you have permission to remove this
(ftp://ftp.cs.berkeley.edu/pub/4bsd/README.Impt.License.Change).
Also, you must remove this clause for the code to be suitable for
inclusion in Linux. Not only is the advertising clause incompatible
with the GPL, but imagine what a pain it would be to include this
acknowedgement in any sort of advertisement. If you think I'm
overreacting, check out this lovely cruft from NetBSD's INSTALL
document:


     This product includes software developed by the University of California,
     Berkeley and its contributors.
     This product includes software developed by The NetBSD Foundation, Inc.
     This product includes software developed by the NetBSD Foundation,
     Inc. and its contributors.
     This product includes software developed by the Computer Systems Engi-
     neering Group at Lawrence Berkeley Laboratory.
     This product includes software developed by Adam Glass and Charles Han-
     num.
     This product includes software developed by Adam Glass and Charles M.
     Hannum.
     This product includes software developed by Adam Glass.
     This product includes software developed by Alistair G. Crooks.
     This product includes software developed by Amancio Hasty and Roger
     Hardiman.
     This product includes software developed by Berkeley Software Design,
     Inc.
     This product includes software developed by Bill Paul.
     This product includes software developed by Charles D. Cranor and Wash-
     ington University.
     This product includes software developed by Charles D. Cranor.
     This product includes software developed by Charles Hannum, by the Uni-
     versity of Vermont and State Agricultural College and Garrett A. Wollman,
     by William F. Jolitz, and by the University of California, Berkeley,
     Lawrence Berkeley Laboratory, and its contributors.
     This product includes software developed by Charles Hannum.
     This product includes software developed by Charles M. Hannum.
     This product includes software developed by Chris Provenzano.
     This product includes software developed by Christian E. Hopps.
     This product includes software developed by Christopher G. Demetriou for
     the NetBSD Project.
     This product includes software developed by Christopher G. Demetriou.
     This product includes software developed by Christos Zoulas.
     This product includes software developed by David Jones and Gordon Ross.
     This product includes software developed by Dean Huxley.
     This product includes software developed by Eric S. Hvozda.
     This product includes software developed by Ezra Story.
     This product includes software developed by Gardner Buchanan.
     This product includes software developed by Gordon Ross.
     This product includes software developed by Gordon W. Ross and Leo Wep-
     pelman.
     This product includes software developed by Gordon W. Ross.
     This product includes software developed by Hauke Fath.
     This product includes software developed by HAYAKAWA Koichi.
     This product includes software developed by Hellmuth Michaelis and Joerg
     Wunsch.
     This product includes software developed by Herb Peyerl.
     This product includes software developed by Holger Veit and Brian Moore
     for use with "386BSD" and similar operating systems.
     This product includes software developed by Hubert Feyrer for the NetBSD
     Project.
     This product includes software developed by Iain Hibbert.
     This product includes software developed by Ian W. Dall.
     This product includes software developed by Ignatios Souvatzis for the
     NetBSD Project.
     This product includes software developed by Jason R. Thorpe for And Com-
     munications, http://www.and.com/.
     This product includes software developed by Joachim Koenig-Baltes.
     This product includes software developed by Jochen Pohl for The NetBSD
     Project.
     This product includes software developed by John Polstra.
     This product includes software developed by Jonathan Stone and Jason R.
     Thorpe for the NetBSD Project.
     This product includes software developed by Jonathan Stone for the NetBSD
     Project.
     This product includes software developed by Jonathan Stone.
     This product includes software developed by Julian Highfield.
     This product includes software developed by Kenneth Stailey.
     This product includes software developed by Leo Weppelman.
     This product includes software developed by Lloyd Parkes.
     This product includes software developed by Manuel Bouyer.
     This product includes software developed by Marc Horowitz.
     This product includes software developed by Mark Brinicombe for the NetB-
     SD Project.
     This product includes software developed by Mark Brinicombe.
     This product includes software developed by Mark Tinguely and Jim Lowe.
     This product includes software developed by Markus Wild.
     This product includes software developed by Martin Husemann and Wolfgang
     Solfrank.
     This product includes software developed by Mats O Jansson and Charles D.
     Cranor.
     This product includes software developed by Mats O Jansson.
     This product includes software developed by Matthias Pfaller.
     This product includes software developed by Michael L. Hitch.
     This product includes software developed by Niels Provos.
     This product includes software developed by Paul Kranenburg.
     This product includes software developed by Paul Mackerras.
     This product includes software developed by Peter Galbavy.
     This product includes software developed by Philip A. Nelson.
     This product includes software developed by Rodney W. Grimes.
     This product includes software developed by Roland C. Dowdeswell.
     This product includes software developed by Rolf Grossmann.
     This product includes software developed by Scott Bartram.
     This product includes software developed by SigmaSoft, Th. Lockert.
     This product includes software developed by Tatoku Ogaito for the NetBSD
     Project.
     This product includes software developed by Terrence R. Lambert.
     This product includes software developed by Theo de Raadt and John
     Brezak.
     This product includes software developed by Theo de Raadt.
     This product includes software developed by Tohru Nishimura for the NetB-
     SD Project.
     This product includes software developed by TooLs GmbH.
     This product includes software designed by William Allen Simpson.
     This product includes software developed by Winning Strategies, Inc.
     This product includes software developed by Zembu Labs, Inc.
     This product includes software developed by the Center for Software Sci-
     ence at the University of Utah.
     This product includes software developed by the Computer Systems Labora-
     tory at the University of Utah.
     This product includes software developed by the University of Calgary De-
     partment of Computer Science and its contributors.
     This product includes software developed by the University of Vermont and
     State Agricultural College and Garrett A. Wollman.
     This product includes software developed for the FreeBSD project.
     This product includes software developed for the Internet Software Con-
     sortium by Ted Lemon.
     This product includes software developed for the NetBSD Project by Frank
     van der Linden.
     This product includes software developed for the NetBSD Project by Jason
     R. Thorpe.
     This product includes software developed for the NetBSD Project by John
     M. Vinopal.
     This product includes software developed for the NetBSD Project by
     Matthias Drochner.
     This product includes software developed for the NetBSD Project by
     Matthieu Herrb.
     This product includes software developed for the NetBSD Project by Perry
     E. Metzger.
     This product includes software developed for the NetBSD Project by Pier-
     mont Information Systems Inc.
     This product includes software developed for the NetBSD Project by Ted
     Lemon.
     This product includes software developed for the NetBSD Project by Wasabi
     Systems, Inc.
     This product includes software developed by LAN Media Corporation and its
     contributors.
     This product includes software developed by Michael Graff for the NetBSD
     Project.
     This product includes software developed by Niklas Hallqvist, C Stone and
     Job de Haas.
     This product includes software developed by Eric Young (eay@min-
     com.oz.au).
     This product includes software developed by the OpenSSL Project for use
     in the OpenSSL Toolkit (http://www.openssl.org/).
     This product includes software developed by the University of Oregon.
     This product includes software developed by the University of Southern
     California and/or Information Sciences Institute.
     This product includes software developed by Internet Initiative Japan
     Inc.
     This product includes software developed by Reinoud Zandijk.
     This product includes software developed at the Information Technology
     Division, US Naval Research Laboratory.

     In the following statement, "This software" refers to the Mitsumi CD-ROM
     driver:
           This software was developed by Holger Veit and Brian Moore for use
           with "386BSD" and similar operating systems.  "Similar operating
           systems" includes mainly non-profit oriented systems for research
           and education, including but not restricted to "NetBSD" , "FreeBSD"
           , "Mach" (by CMU).
     In the following statement, "This software" refers to the parallel port
     driver:
           This software is a component of "386BSD" developed by William F.
           Jolitz, TeleMuse.


