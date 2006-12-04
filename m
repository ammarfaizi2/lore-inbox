Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936802AbWLDNEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936802AbWLDNEn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 08:04:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936803AbWLDNEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 08:04:43 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:54755 "EHLO
	filer.fsl.cs.sunysb.edu") by vger.kernel.org with ESMTP
	id S936802AbWLDNEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 08:04:41 -0500
Date: Mon, 4 Dec 2006 08:04:35 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: bert hubert <bert.hubert@netherlabs.nl>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: Unionfs: Stackable namespace unification filesystem
Message-ID: <20061204130435.GA24028@filer.fsl.cs.sunysb.edu>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu> <20061204125740.GA3901@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204125740.GA3901@outpost.ds9a.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 01:57:40PM +0100, bert hubert wrote:
> On Mon, Dec 04, 2006 at 07:30:33AM -0500, Josef 'Jeff' Sipek wrote:
> > The following patches are in a git repo at:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/jsipek/unionfs.git
> 
> Jeff,
> 
> Do you have a pointer to a quick blurb on this work?

There's a lot of material on our website, http://www.unionfs.org.

The one sentence summary would be: Unionfs is a stackable unification
filesystem, which can appear to merge the contents of several directories
(branches), while keeping their physical content separate.

Hope that helps,

Josef "Jeff" Sipek.
