Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263418AbUJ2Rj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263418AbUJ2Rj7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 13:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUJ2RjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:39:04 -0400
Received: from ipcop.bitmover.com ([192.132.92.15]:12713 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263382AbUJ2Rg6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:36:58 -0400
Date: Fri, 29 Oct 2004 10:36:42 -0700
From: Larry McVoy <lm@bitmover.com>
To: Ram?n Rey Vicente <ramon.rey@hispalinux.es>
Cc: Larry McVoy <lm@bitmover.com>, Xavier Bestel <xavier.bestel@free.fr>,
       James Bruce <bruce@andrew.cmu.edu>, Linus Torvalds <torvalds@osdl.org>,
       Roman Zippel <zippel@linux-m68k.org>,
       Andrea Arcangeli <andrea@novell.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BK kernel workflow
Message-ID: <20041029173642.GA5318@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ram?n Rey Vicente <ramon.rey@hispalinux.es>,
	Larry McVoy <lm@bitmover.com>,
	Xavier Bestel <xavier.bestel@free.fr>,
	James Bruce <bruce@andrew.cmu.edu>,
	Linus Torvalds <torvalds@osdl.org>,
	Roman Zippel <zippel@linux-m68k.org>,
	Andrea Arcangeli <andrea@novell.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0410251017010.27766@ppc970.osdl.org> <Pine.LNX.4.61.0410252350240.17266@scrub.home> <Pine.LNX.4.58.0410251732500.427@ppc970.osdl.org> <Pine.LNX.4.61.0410270223080.877@scrub.home> <Pine.LNX.4.58.0410261931540.28839@ppc970.osdl.org> <4180B9E9.3070801@andrew.cmu.edu> <20041028135348.GA18099@work.bitmover.com> <1098972379.3109.24.camel@gonzales> <20041028151004.GA3934@work.bitmover.com> <41827B89.4070809@hispalinux.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41827B89.4070809@hispalinux.es>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 07:19:05PM +0200, Ram?n Rey Vicente wrote:
> In Spain, reverse engineering is allowed for interoperability.

And in lots of other places.  Which has been mentioned in this and other
instances of this discussion for the last 5 years.  And the response is
that BK already gives you documented ways to interoperate, extensively
documented, in fact.  You can get data and/or metadata into and out of
BK from the command line.  You could create your own network protocol,
client, and server using the documented interfaces that BK has.  You
could create your own CVS2BK tool, your own BK2CVS tool, etc., all
using documented interfaces.

The point of the interoperability hole is for commercial products
which try and lock up your data.  We don't do that, in fact, we are
*dramatically* more open about getting data in and out, with all
the metadata, than any other commercial product.  Go try and get the
same information from Perforce, Clearcase, or even CVS or Subversion.
Good luck.

Given that BK isn't hiding anything, the "reverse engineering for
interoperability" does not apply.  Hello?  Anyone listening?  Didn't
think so.  Sigh.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
