Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265049AbTFLXRe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 19:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265046AbTFLXRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 19:17:33 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:61333 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265047AbTFLXR0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 19:17:26 -0400
Date: Thu, 12 Jun 2003 16:32:59 -0700
From: Greg KH <greg@kroah.com>
To: Robert Love <rml@tech9.net>
Cc: Patrick Mochel <mochel@osdl.org>, Andrew Morton <akpm@digeo.com>,
       sdake@mvista.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udev enhancements to use kernel event queue
Message-ID: <20030612233258.GA2079@kroah.com>
References: <Pine.LNX.4.44.0306121624470.11379-100000@cherise> <1055460564.662.339.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055460564.662.339.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 04:29:25PM -0700, Robert Love wrote:
> On Thu, 2003-06-12 at 16:25, Patrick Mochel wrote:
> 
> > Yeah, how about this ammended patch? 
> 
> Both this and Greg's look fine.
> 
> I guess this is preferred, since the lock hold time is shorter :)

Heh, I don't care either way, It's up to Pat...

thanks for pointing this out,

greg k-h
