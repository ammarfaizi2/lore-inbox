Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267291AbUJGFxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267291AbUJGFxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 01:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269710AbUJGFxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 01:53:44 -0400
Received: from havoc.gtf.org ([69.28.190.101]:21679 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S267291AbUJGFxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 01:53:38 -0400
Date: Thu, 7 Oct 2004 01:49:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: alan <alan@clueserver.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Why no linux-2.6.8.2? (was Re: new dev model)
Message-ID: <20041007054909.GA23561@havoc.gtf.org>
References: <200410070134_MC3-1-8BA9-A215@compuserve.com> <Pine.LNX.4.44.0410062145530.26294-100000@www.fnordora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410062145530.26294-100000@www.fnordora.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 06, 2004 at 09:46:46PM -0700, alan wrote:
> On Thu, 7 Oct 2004, Chuck Ebbert wrote:
> 
> > Why has linux 2.6.8 been abandoned at version 2.6.8.1?
> > 
> > There exist fixes that could go into 2.6.8.2:
> > 
> >         process start time doesn't match system time
> >         FDDI frame doesn't allow 802.3 hwtype
> >         NFS server using XFS filesystem on SMP machine oopses
> > 
> > I'm sure there are more...
> > 
> > So why is 2.6.8.1 a "dead branch?"
> 
> It was an emergency "paperbag" release number.
> 
> All paperbag releases are made from dead branches.


Thanks to BitKeeper no properly-tagged branch is ever dead.

Anyone could make a 2.6.8.2 if they so chose.

	Jeff



