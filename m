Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262365AbRERQMX>; Fri, 18 May 2001 12:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262368AbRERQMN>; Fri, 18 May 2001 12:12:13 -0400
Received: from ns.caldera.de ([212.34.180.1]:1922 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S262365AbRERQL5>;
	Fri, 18 May 2001 12:11:57 -0400
Date: Fri, 18 May 2001 18:09:09 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: "Eric S. Raymond" <esr@thyrsus.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Tom Rini <trini@kernel.crashing.org>,
        Michael Meissner <meissner@spectacle-pond.org>,
        Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
Message-ID: <20010518180909.A10357@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Tom Rini <trini@kernel.crashing.org>,
	Michael Meissner <meissner@spectacle-pond.org>,
	Keith Owens <kaos@ocs.com.au>, CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010518105353.A13684@thyrsus.com> <E150mKO-0007FF-00@the-village.bc.nu> <20010518120434.F14309@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010518120434.F14309@thyrsus.com>; from esr@thyrsus.com on Fri, May 18, 2001 at 12:04:34PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2001 at 12:04:34PM -0400, Eric S. Raymond wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk>:
> > > I don't want to do (a); it conflicts with my design objective of
> > > simplifying configuration enough that Aunt Tillie can do it.  I won't 
> > > do that unless I see a strong consensus that it's the only Right Thing.
> > 
> > Its a good way of getting the defaults right. It may also be an appropriate
> > way of guiding presentation (eg putting the stuff the ruleset says you wont
> > have under a subcategory so you would see
> > 
> > 
> > 		CPU type
> > 		Devices
> > 		blah
> > 		blah
> > 		Other Options
> > 			IDE disk
> > 			Cardbus
> 
> I want to understand what you're driving at here and I don't get it.  What's
> the referent of "Its"?  Are you saying you think Aunt Tillie's view of the
> world should guide the presentation of options?

Aunt Tillie shouldn't try to manually configure a kernel.

	Christoph

P.S. _please_ shorten your .sig
-- 
Whip me.  Beat me.  Make me maintain AIX.
