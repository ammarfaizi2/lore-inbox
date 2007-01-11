Return-Path: <linux-kernel-owner+w=401wt.eu-S1750822AbXAKR7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750822AbXAKR7F (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 12:59:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbXAKR7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 12:59:05 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59639 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822AbXAKR7E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 12:59:04 -0500
Date: Thu, 11 Jan 2007 17:58:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: Christoph Hellwig <hch@infradead.org>, jeff@garzik.org,
       shemminger@osdl.org, csnook@redhat.com, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [PATCH 2/4] atl1: Header files for Attansic L1 driver
Message-ID: <20070111175833.GA15053@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jay Cliburn <jacliburn@bellsouth.net>, jeff@garzik.org,
	shemminger@osdl.org, csnook@redhat.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20070111004137.GC2624@osprey.hogchain.net> <20070111092704.GB3141@infradead.org> <20070111165330.GA6191@osprey.hogchain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070111165330.GA6191@osprey.hogchain.net>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 11, 2007 at 10:53:30AM -0600, Jay Cliburn wrote:
> On Thu, Jan 11, 2007 at 09:27:04AM +0000, Christoph Hellwig wrote:
> > On Wed, Jan 10, 2007 at 06:41:37PM -0600, Jay Cliburn wrote:
> > > +/**
> > > + * atl1.h - atl1 main header
> > 
> > Please remove these kind of comments, they get out of date far too soon
> > and don't really help anything.  (Also everywhere else in the driver)
> 
> Is your concern here with the filename portion of the comment only, or
> with the entire comment including the copyright and other material?

Only the line I quoted.  Copyright statements and similar things are
obviously fine :)
