Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315838AbSEEIms>; Sun, 5 May 2002 04:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315839AbSEEImr>; Sun, 5 May 2002 04:42:47 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:51439
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S315838AbSEEImq>; Sun, 5 May 2002 04:42:46 -0400
Date: Sun, 5 May 2002 01:42:43 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Vikram <vvikram@stanford.edu>
Cc: Jeff Dike <jdike@karaya.com>, Guest section DW <dwguest@win.tue.nl>,
        Gerrit Huizenga <gh@us.ibm.com>, linux-kernel@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        user-mode-linux-user@lists.sourceforge.net
Subject: Re: UML is now self-hosting!
Message-ID: <20020505084243.GF2392@matchmail.com>
Mail-Followup-To: Vikram <vvikram@stanford.edu>,
	Jeff Dike <jdike@karaya.com>, Guest section DW <dwguest@win.tue.nl>,
	Gerrit Huizenga <gh@us.ibm.com>, linux-kernel@vger.kernel.org,
	user-mode-linux-devel@lists.sourceforge.net,
	user-mode-linux-user@lists.sourceforge.net
In-Reply-To: <20020505082505.GE2392@matchmail.com> <Pine.GSO.4.44.0205050127080.6221-100000@epic7.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 05, 2002 at 01:29:43AM -0700, Vikram wrote:
> 
> >
> > How would this be better than MOSIX, or other clustering solutions?
> >
> > Any URLs you may have on this would be quite helpful.
> 
> uh-huh, you miss the pt maybe? uml offers a great testing, debugging,
> developing platform. the whole idea is to replace the real thing (say like
> kernel devel) with UML and your qn is more like why cant we use the real
> thing itself....:)

If you want to test clustering (or "UML SMP over several seperate hosts"
-JDike) with UML, why not just create a UML kernel with the clustering
support (ie, MOSIX) in that UML kernel?  

Really, I'm just asking what the benifit is to use UML for clustering as
oposed to MOSIX.  I can think of one, testing NUMA without special
hardware...
