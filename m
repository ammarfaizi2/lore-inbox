Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269572AbTGOTtO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 15:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269616AbTGOTtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 15:49:14 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:30733 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S269572AbTGOTtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 15:49:11 -0400
Date: Tue, 15 Jul 2003 22:03:57 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Jeff Garzik <jgarzik@pobox.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Message-ID: <20030715200357.GA1121@win.tue.nl>
References: <20030711155613.GC2210@gtf.org> <20030711203850.GB20970@win.tue.nl> <20030715000331.GB904@matchmail.com> <20030715170804.GA1089@win.tue.nl> <20030715194215.GE904@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030715194215.GE904@matchmail.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 12:42:15PM -0700, Mike Fedyk wrote:

> > DOS partition table works up to 2^32 sectors, and with
> > 2^9-byte sectors that is 2 TiB.
> > 
> > People are encountering that limit already. We need something
> > better, either use some existing scheme, or invent something.
> 
> Please point me to an URL for a 2TB hard drive.  Or are you pointing out
> that hardware raid setups look like a single drive (block device)? 

Yes.


