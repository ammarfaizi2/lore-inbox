Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315180AbSD2UAm>; Mon, 29 Apr 2002 16:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315181AbSD2UAl>; Mon, 29 Apr 2002 16:00:41 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:30475 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S315180AbSD2UAl>; Mon, 29 Apr 2002 16:00:41 -0400
Date: Mon, 29 Apr 2002 22:00:35 +0200
From: tomas szepe <kala@pinerecords.com>
To: Sandy Harris <pashley@storm.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The tainted message
Message-ID: <20020429200035.GA26567@louise.pinerecords.com>
In-Reply-To: <E171TzX-0008PF-00@the-village.bc.nu> <1019926629.2045.698.camel@phantasy> <1020099580.5131.14.camel@w-beattie1> <20020429171516.GA25377@louise.pinerecords.com> <20020429184331.3230f5ab.spyro@armlinux.org> <20020429174232.GA25502@louise.pinerecords.com> <ui6rcugr35a6h8u1tf6sq5js4mn5c19sq2@4ax.com> <20020429192107.GA26369@louise.pinerecords.com> <3CCD93E6.F637706A@storm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-OS: Linux/sparc 2.2.21-rc3-ext3-0.0.7a SMP (up 7 days, 14:34)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > >> thie warning should be:
> > > >>
> > > >> Warning: Module %s is not open source, and as such, loading it will make
> > > >> your kernel un-debuggable. Please do not submit bug reports from a kernel
> > > >> with this module loaded, as they will be useless, and likely ignored.
> > > >
> > > >Very good! I'd only change the tense to "The non-opensource module %s is
> > > >about to be loaded, which will make your kernel impossible to debug," so
> > > >that it's crystal clear that the message is not a failure notification.
> > >
> > > Pschologically it would be better to phrase it as a postive statement.
> > >
> > > Warning: Module %s is not open source, and as such, loading it will
> > > make your kernel un-debuggable. Before reporting problems to
> > > Linux-kernel, please replicate the problem without the module loaded.
> > 
> > You're right. And, hmmm, tell you what.. I also like your version because
> > it makes no statements whatsoever about vendor support, or support from
> > anyone else than the people on linux-kernel.
> > 
> > Now, would anyone attempt to sum up all the points made here and come up
> > w/ something like a "final-draft" proposal?
> 
> Warning: Source code for module %s is not publicly available. Problems
> with a kernel that has loaded this module can be debugged only by someone
> with access to the module source. Before reporting a problem to the Linux
> kernel mailing list, please replicate the problem without the module loaded.


Indeed, this would certainly do much better than the current caption.
"What say you, Mr. ModutilsMaintainer?" <wink wink>


T.
