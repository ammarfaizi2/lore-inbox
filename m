Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbVEFPuf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbVEFPuf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 11:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVEFPuf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 11:50:35 -0400
Received: from mail.kroah.org ([69.55.234.183]:59361 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261200AbVEFPua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 11:50:30 -0400
Date: Fri, 6 May 2005 08:50:21 -0700
From: Greg KH <greg@kroah.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Andries Brouwer <aebr@win.tue.nl>, "Randy.Dunlap" <rddunlap@osdl.org>,
       joecool1029@gmail.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Empty partition nodes not created (was device node issues with recent mm's and udev)
Message-ID: <20050506155020.GA6904@kroah.com>
References: <d4757e6005050219514ece0c0a@mail.gmail.com> <20050503031421.GA528@kroah.com> <20050502202620.04467bbd.rddunlap@osdl.org> <20050506080056.GD4604@pclin040.win.tue.nl> <20050506081009.GX23013@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050506081009.GX23013@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 06, 2005 at 01:10:09AM -0700, Chris Wright wrote:
> * Andries Brouwer (aebr@win.tue.nl) wrote:
> > No, there is no problem but an intentional change in behaviour in -mm
> > and now also in 2.6.11.8.
> 
> I think this should be backed out of -stable.

I agree, I'll go do it in the tree right now, sorry about this.

greg k-h
