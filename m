Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422680AbWHEHRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422680AbWHEHRl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 03:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422681AbWHEHRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 03:17:41 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:14344 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1422680AbWHEHRk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 03:17:40 -0400
Date: Fri, 4 Aug 2006 13:03:39 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: Where does kernel/resource.c.1 file come from?
Message-ID: <20060804130339.GA4014@ucw.cz>
References: <200607251554.50484.eike-kernel@sf-tec.de> <20060725151520.GA15681@mars.ravnborg.org> <200607281603.38978.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607281603.38978.eike-kernel@sf-tec.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I'm playing around with my local copy of linux-2.6 git tree. I'm building
> > > everything to a separate directory using O= to keep "git status" silent.
> > >
> > > After building I sometimes find a file kernel/resource.c.1 in my git tree
> > > that doesn't really belong there. Who is generating this file, for what
> > > reason and why doesn't it get created in my output directory?
> >
> > Can you also try to make sure that this file is generated as part of the
> > build process. git status before and after should do it.
> 
> I did a full rebuild and did not see the file again. Weird.

Is not it emacs's (or other editor's?) numbered backup?


-- 
Thanks for all the (sleeping) penguins.
