Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263359AbUJ2RuI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263359AbUJ2RuI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 13:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263162AbUJ2Rsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 13:48:36 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:15579 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S263345AbUJ2RsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 13:48:00 -0400
Date: Fri, 29 Oct 2004 19:47:53 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, linux-arch@vger.kernel.org
Subject: Re: New kbuild filename: Kbuild
In-Reply-To: <20041029191231.GB8246@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0410291946060.17266@scrub.home>
References: <20041028185917.GA9004@mars.ravnborg.org> <20041028190020.GB9004@mars.ravnborg.org>
 <20041029115903.GC11391@infradead.org> <20041029191231.GB8246@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 29 Oct 2004, Sam Ravnborg wrote:

> > If you really want to improve things implement something like
> > 
> >  module foo.ko
> >  sources foo.c blah.c
> >  sources foobar.c if FOO_BAR
> > 
> > in Kconfig and get rid of driver makefiles compeltely
> 
> I'm in favour of this too - but so far Roman has rejected it.

I never rejected this, I just haven't implemented this yet. :)

bye, Roman
