Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVBGAgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVBGAgP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 19:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261328AbVBGAgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 19:36:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62631 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261325AbVBGAgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 19:36:14 -0500
Date: Mon, 7 Feb 2005 00:36:10 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Pozsar Balazs <pozsy@uhulinux.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: msdos/vfat defaults are annoying
Message-ID: <20050207003610.GP8859@parcelfarce.linux.theplanet.co.uk>
References: <4205AC37.3030301@comcast.net> <20050206070659.GA28596@infradead.org> <20050206232108.GA31813@ojjektum.uhulinux.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050206232108.GA31813@ojjektum.uhulinux.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2005 at 12:21:08AM +0100, Pozsar Balazs wrote:
> On Sun, Feb 06, 2005 at 07:06:59AM +0000, Christoph Hellwig wrote:
> > On Sun, Feb 06, 2005 at 12:33:43AM -0500, John Richard Moser wrote:
> > > I dunno.  I can never understand the innards of the kernel devs' minds.
> > 
> > filesystem detection isn't handled at the kerne level.
> 
> Yeah, but the link order could be changed... Patch inlined.

And just what does the link order (or changes thereof) have to do with that?
