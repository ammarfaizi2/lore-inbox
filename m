Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261168AbUJ3BiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbUJ3BiS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 21:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbUJ2Tha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:37:30 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:5788 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261214AbUJ2SqB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 14:46:01 -0400
Date: Fri, 29 Oct 2004 22:46:30 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       linux-arch@vger.kernel.org
Subject: Re: New kbuild filename: Kbuild
Message-ID: <20041029204630.GA11016@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
References: <20041028185917.GA9004@mars.ravnborg.org> <20041028190020.GB9004@mars.ravnborg.org> <20041029115903.GC11391@infradead.org> <20041029191231.GB8246@mars.ravnborg.org> <Pine.LNX.4.61.0410291946060.17266@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0410291946060.17266@scrub.home>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 29, 2004 at 07:47:53PM +0200, Roman Zippel wrote:
> Hi,
> 
> On Fri, 29 Oct 2004, Sam Ravnborg wrote:
> 
> > > If you really want to improve things implement something like
> > > 
> > >  module foo.ko
> > >  sources foo.c blah.c
> > >  sources foobar.c if FOO_BAR
> > > 
> > > in Kconfig and get rid of driver makefiles compeltely
> > 
> > I'm in favour of this too - but so far Roman has rejected it.
> 
> I never rejected this, I just haven't implemented this yet. :)

OK!

	Sam
