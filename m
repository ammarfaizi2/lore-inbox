Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbUCGQZj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 11:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262217AbUCGQZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 11:25:38 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:30245 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262194AbUCGQZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 11:25:27 -0500
Date: Sun, 7 Mar 2004 17:25:23 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Daniel Egger <degger@fhm.edu>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com, linux-net@vger.kernel.org
Subject: Re: [2.6 patch] MAINTAINERS: remove LAN media entry
Message-ID: <20040307162523.GA2440@mars.ravnborg.org>
Mail-Followup-To: Adrian Bunk <bunk@fs.tum.de>,
	Daniel Egger <degger@fhm.edu>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	jgarzik@pobox.com, linux-net@vger.kernel.org
References: <20040226225131.GX5499@fs.tum.de> <A93036A2-68C5-11D8-A46E-000A9597297C@fhm.edu> <20040227205446.GZ5499@fs.tum.de> <DC71BC17-69DC-11D8-BD1F-000A9597297C@fhm.edu> <20040307155146.GN22479@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040307155146.GN22479@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 07, 2004 at 04:51:47PM +0100, Adrian Bunk wrote:
> On Sat, Feb 28, 2004 at 11:57:11AM +0100, Daniel Egger wrote:
> > On Feb 27, 2004, at 9:54 pm, Adrian Bunk wrote:
> > 
> > >IOW:
> > >The entry from MAINTAINER can be removed?
> > 
> > This one for sure. The same is probably sensible for the
> > drivers, too. It's just too confusing to not several
> > versions of the driver floating around which need different
> > tools. And since the manufacturer propagates their own
> > version, the linux one should go...
> >...
> 
> 
> It's a question whether removing drivers from a stable kernel series is
> a good idea, but the following is definitely correct:

Why do you remove it completely, instead of just marking it unmaintained,
and remove the address information?
They when searching you know the you have found the right entry, but
unfortunately it is unmaintained.

	Sam
