Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVCHOOV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVCHOOV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 09:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261331AbVCHOOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 09:14:03 -0500
Received: from galileo.bork.org ([134.117.69.57]:23173 "HELO galileo.bork.org")
	by vger.kernel.org with SMTP id S261340AbVCHONL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 09:13:11 -0500
Date: Tue, 8 Mar 2005 09:13:12 -0500
From: Martin Hicks <mort@wildopensource.com>
To: luc@saillard.org
Cc: Greg KH <greg@kroah.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org, alan@redhat.com
Subject: Re: [PATCH] Restore PWC driver
Message-ID: <20050308141312.GC26705@localhost>
References: <200503072216.j27MGLqR024373@hera.kernel.org> <20050308052643.GA16222@kroah.com> <20050308095938.GA30673@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050308095938.GA30673@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Mar 08, 2005 at 04:59:38AM -0500, Alan Cox wrote:
> On Mon, Mar 07, 2005 at 09:26:43PM -0800, Greg KH wrote:
> 
> > So, who's going to fix up:
> > 	- the MAINTAINERS entry
> > 	- the coding style
> > 	- drop that unneeded changelog file
> > 	- fix the module help text to point to the proper file (or put
> > 	  the file in the proper place.)
> > 	- get rid of the c++ crud in the header file
> > 	- drop the "magic" nonsense
> > 	- the ioctls to work on 64bit machines
> > ?
> 
> Luc and I'm happy to help doing further work on it. However it's been like that
> in kernel for years so it might also be a good one for the janitors to join in
> on ?

I'd like to see this driver back in mainline too.  Luc, please contact
me and we'll get this working correctly on a bunch of machines.

mh

-- 
Martin Hicks                Wild Open Source Inc.
mort@wildopensource.com     613-266-2296
