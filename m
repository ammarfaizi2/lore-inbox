Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262782AbTKYR7G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 12:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262789AbTKYR7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 12:59:06 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:17683 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S262782AbTKYR7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 12:59:04 -0500
Date: Tue, 25 Nov 2003 17:59:17 +0000
From: Joe Thornber <thornber@sistina.com>
To: Christoph Hellwig <hch@infradead.org>, Joe Thornber <thornber@sistina.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [Patch 3/5] dm: make v4 of the ioctl interface the default
Message-ID: <20031125175917.GH524@reti>
References: <20031125162451.GA524@reti> <20031125163313.GD524@reti> <20031125172059.A22743@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031125172059.A22743@infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 05:20:59PM +0000, Christoph Hellwig wrote:
> On Tue, Nov 25, 2003 at 04:33:13PM +0000, Joe Thornber wrote:
> > Make the version-4 ioctl interface the default kernel configuration option.
> > If you have out of date tools you will need to use the v1 interface.
> 
> So why do we keep the old version at all?

See my earlier email where I said I don't want to keep it.  Both
versions have only been present while people are migrating.

- Joe
