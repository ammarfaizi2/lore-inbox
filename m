Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbTDTPdN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 11:33:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbTDTPdN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 11:33:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61852 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263610AbTDTPdM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 11:33:12 -0400
Date: Sun, 20 Apr 2003 16:45:13 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Shachar Shemesh <lkml@shemesh.biz>
Cc: Ben Collins <bcollins@debian.org>, Larry McVoy <lm@work.bitmover.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: BK->CVS, kernel.bkbits.net
Message-ID: <20030420154513.GH10374@parcelfarce.linux.theplanet.co.uk>
References: <20030417162723.GA29380@work.bitmover.com> <20030420013440.GG2528@phunnypharm.org> <3EA24CF8.5080609@shemesh.biz> <20030420130123.GK2528@phunnypharm.org> <3EA2A285.2070307@shemesh.biz> <20030420134712.GM2528@phunnypharm.org> <3EA2B1BB.2060600@shemesh.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA2B1BB.2060600@shemesh.biz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 20, 2003 at 05:42:03PM +0300, Shachar Shemesh wrote:
> Ben Collins wrote:
> 
> >CVSup is only available on i386 because of the compiler from what I can
> >see.
> > 
> >
> The site offers binary images for download for FreeBSD and Digital Unix 
> (Alpha), and Solaris Sparc. It is therefor unlikely that this is a 
> problem with lack of development tools. More probably - the maintainers 
> did not have these platforms available to them.

Care to take a look at the bootstrap procedures for Modula 3 compiler?
