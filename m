Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264451AbUAaAz3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 19:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264507AbUAaAz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 19:55:29 -0500
Received: from mail.kroah.org ([65.200.24.183]:4555 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264451AbUAaAz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 19:55:27 -0500
Date: Fri, 30 Jan 2004 16:55:26 -0800
From: Greg KH <greg@kroah.com>
To: David =?iso-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: Typo (Re: [PATCH] i2c driver fixes for 2.6.2-rc2)
Message-ID: <20040131005526.GE10860@kroah.com>
References: <10752464532256@kroah.com> <200401291227.15413.ender@debian.org> <20040129194705.GD5681@kroah.com> <200401301058.29324.ender@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200401301058.29324.ender@debian.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 10:58:29AM +0100, David Martínez Moreno wrote:
> El Jueves, 29 de Enero de 2004 20:47, Greg KH escribió:
> > On Thu, Jan 29, 2004 at 12:27:15PM +0100, David Martínez Moreno wrote:
> > > 	Sure, it's only a small thing in return for all that Linux has given to
> > > me.
> > >
> > > 	Following patch fixes two typos and a missing full stop. Applies cleanly
> > > against 2.6.2-rc2 + i2c patches you just submitted.
> >
> > Hm, your mailer munged the patch (due to the PGP signature), care to
> > redo it so that it can be applied?
> 
> 	I agree. :-)
> 
> 	There goes again, without GPG sig.

Much nicer.

> 	Following patch fixes two typos and a missing full stop. Applies cleanly
> against 2.6.2-rc2 + i2c patches you just submitted.

Thanks, I've applied this to my trees.

greg k-h
