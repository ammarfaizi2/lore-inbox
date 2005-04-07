Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVDGHvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVDGHvE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 03:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVDGHvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 03:51:04 -0400
Received: from 71-33-33-84.albq.qwest.net ([71.33.33.84]:54716 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262003AbVDGHuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 03:50:54 -0400
Date: Thu, 7 Apr 2005 01:53:02 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Martin Pool <mbp@sourcefrog.net>, linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM saga..
In-Reply-To: <20050407014727.GA17970@havoc.gtf.org>
Message-ID: <Pine.LNX.4.61.0504070152240.12823@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
 <20050406193911.GA11659@stingr.stingr.net> <pan.2005.04.07.01.40.20.998237@sourcefrog.net>
 <20050407014727.GA17970@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr 2005, Jeff Garzik wrote:

> On Thu, Apr 07, 2005 at 11:40:23AM +1000, Martin Pool wrote:
> > On Wed, 06 Apr 2005 23:39:11 +0400, Paul P Komkoff Jr wrote:
> > 
> > > http://bazaar-ng.org/
> > 
> > I'd like bazaar-ng to be considered too.  It is not ready for adoption
> > yet, but I am working (more than) full time on it and hope to have it
> > be usable in a couple of months.  
> > 
> > bazaar-ng is trying to integrate a lot of the work done in other systems
> > to make something that is simple to use but also fast and powerful enough
> > to handle large projects.
> > 
> > The operations that are already done are pretty fast: ~60s to import a
> > kernel tree, ~10s to import a new revision from a patch.  
> 
> By "importing", are you saying that importing all 60,000+ changesets of
> the current kernel tree took only 60 seconds?

Probably `cvs import` equivalent.
