Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263925AbTICQcK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263933AbTICQcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:32:10 -0400
Received: from mail.kroah.org ([65.200.24.183]:48518 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263925AbTICQbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:31:13 -0400
Date: Wed, 3 Sep 2003 09:30:20 -0700
From: Greg KH <greg@kroah.com>
To: Felipe W Damasio <felipewd@terra.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Needed include in usb/gadget/net2280
Message-ID: <20030903163019.GD3948@kroah.com>
References: <3F514CDC.9060203@terra.com.br> <20030902173846.GA17995@kroah.com> <3F55E4E8.1010208@terra.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F55E4E8.1010208@terra.com.br>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 09:56:08AM -0300, Felipe W Damasio wrote:
> 	Hi Greg,
> 
> Greg KH wrote:
> >On Sat, Aug 30, 2003 at 10:18:20PM -0300, Felipe W Damasio wrote:
> >
> >>	Hi Greg,
> >>
> >>	Attached is a trivial patch which includes the needed 
> >>	linux/version.h header file.
> >>
> >>	This is based on Randy's checkversion.pl script.
> >>
> >>	Please consider applying.
> >
> >
> >Thanks, but I already have this change in my USB tree.  I'll push them
> >all to Linus later today.
> 
> 	I couldn't find this patch on your merge with Linus:
> 
> http://linux.bkbits.net:8080/linux-2.5/patch@1.1406.3.1?nav=index.html|ChangeSet@-1d|cset@1.1406.3.1

Why that changeset?

Why not the changeset associated with this file:
  http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/usb/gadget/net2280.c@1.15
  
> 	Or you're talking about another USB tree merge with Linus? :)

Nope, it was also in the list of patches I sent him yesterday, and is
already in 2.6.0-test4-bk5.

thanks,

greg k-h
