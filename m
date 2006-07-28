Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161169AbWG1OLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161169AbWG1OLQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 10:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161167AbWG1OLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 10:11:16 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:36265 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161169AbWG1OLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 10:11:15 -0400
Date: Fri, 28 Jul 2006 16:10:57 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where does kernel/resource.c.1 file come from?
Message-ID: <20060728141057.GA27837@mars.ravnborg.org>
References: <200607251554.50484.eike-kernel@sf-tec.de> <20060725151520.GA15681@mars.ravnborg.org> <200607281603.38978.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607281603.38978.eike-kernel@sf-tec.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 04:03:38PM +0200, Rolf Eike Beer wrote:
> Am Dienstag, 25. Juli 2006 17:15 schrieb Sam Ravnborg:
> > On Tue, Jul 25, 2006 at 03:54:45PM +0200, Rolf Eike Beer wrote:
> > > Hi,
> > >
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
Let me know if you see it again - then we can try to work out what is
happening.

	Sam
