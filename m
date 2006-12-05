Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967391AbWLEXQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967391AbWLEXQa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 18:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967467AbWLEXQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 18:16:30 -0500
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:33621 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967391AbWLEXQ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 18:16:29 -0500
Date: Tue, 5 Dec 2006 18:16:23 -0500
From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] fsstack: Fix up ecryptfs's fsstack usage
Message-ID: <20061205231623.GB7300@filer.fsl.cs.sunysb.edu>
References: <20061204204024.2401148d.akpm@osdl.org> <20061205191824.GB2240@filer.fsl.cs.sunysb.edu> <20061205192231.GD2240@filer.fsl.cs.sunysb.edu> <20061205142831.9cb3e91c.akpm@osdl.org> <20061205223807.GA7300@filer.fsl.cs.sunysb.edu> <20061205144913.fea98946.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061205144913.fea98946.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2006 at 02:49:13PM -0800, Andrew Morton wrote:
> On Tue, 5 Dec 2006 17:38:07 -0500
> Josef Sipek <jsipek@fsl.cs.sunysb.edu> wrote:
> 
> > > When your patches are queued in -mm please do test them there, and review
> > > others' changes to them, and raise patches against them.  Raising patches
> > > against one's private tree and not testing the code which is planned to be
> > > merged can introduce errors.
> > 
> > Sorry about that. I noticed your fix, and the one by Adrian. And I did add
> > them to my fsstack queue.
> 
> you don't have an fsstack queue any more ;)

Good point :)

> Please, I really do want developers to test their code in -mm once I've
> merged it.  What happens if there's some nasty interaction between your
> patch and someone else's?  We'll not find out about it and it'll get
> merged.

Point taken.

Josef "Jeff" Sipek.

-- 
I already backed up the box once, I can do it again.
