Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262724AbVCPSWB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbVCPSWB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVCPSWB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:22:01 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:21872 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262724AbVCPSVy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:21:54 -0500
Date: Wed, 16 Mar 2005 19:22:15 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm4
Message-ID: <20050316182215.GA8267@mars.ravnborg.org>
References: <20050316040654.62881834.akpm@osdl.org> <1110985632l.8879l.0l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110985632l.8879l.0l@werewolf.able.es>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 03:07:12PM +0000, J.A. Magallon wrote:
> 
> On 03.16, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11/2.6.11-mm4/
> > 
> ...
> >
> > +revert-gconfig-changes.patch
> > 
> >  Back out a recent change which broke gconfig.
> > 
> 
> What was broken ?

It did not display the nice icons with gtk2.4 anymore.
And the fact that it generates ~10 warnings when being compiled annoy me
as well. Although I have not had the courage to try to fix this gtk
stuff.

A patch to fix gconfig on top of linus-latest is very welcome.

	Sam
