Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262369AbRERQAN>; Fri, 18 May 2001 12:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262370AbRERQAD>; Fri, 18 May 2001 12:00:03 -0400
Received: from ns.caldera.de ([212.34.180.1]:49793 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S262369AbRERP75>;
	Fri, 18 May 2001 11:59:57 -0400
Date: Fri, 18 May 2001 17:58:43 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: John Cowan <jcowan@reutershealth.com>
Cc: Jes Sorensen <jes@sunsite.dk>, esr@thyrsus.com,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
Message-ID: <20010518175843.A9347@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>,
	John Cowan <jcowan@reutershealth.com>,
	Jes Sorensen <jes@sunsite.dk>, esr@thyrsus.com,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010505192731.A2374@thyrsus.com> <d33da9tjjw.fsf@lxplus015.cern.ch> <20010513112543.A16121@thyrsus.com> <d3d79awdz3.fsf@lxplus015.cern.ch> <20010515173316.A8308@thyrsus.com> <d3wv7eptuz.fsf@lxplus015.cern.ch> <3B054500.2090408@reutershealth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B054500.2090408@reutershealth.com>; from jcowan@reutershealth.com on Fri, May 18, 2001 at 11:51:28AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2001 at 11:51:28AM -0400, John Cowan wrote:
> Jes Sorensen wrote:
> 
> > Telling them to install an updated gcc for kernel compilation
> > is a necessary evil, which can easily be done without disturbing the
> > rest of the system. Updating the system's python installation is not a
> > reasonable request.
> 
> 
> Au contraire.  It is very reasonable to have both python and python2
> installed.  Having two different gcc versions installed is a big pain
> in the arse.

Fump. Some distributions do even come with two gcc's out of the box.
With the whole egcs and gcc2.95 (dunno about 3.0) you can even share
the compiler driver if you want.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
