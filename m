Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266330AbUA2TrT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266337AbUA2TrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:47:19 -0500
Received: from mail.kroah.org ([65.200.24.183]:10941 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266330AbUA2TrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:47:13 -0500
Date: Thu, 29 Jan 2004 11:47:05 -0800
From: Greg KH <greg@kroah.com>
To: David =?iso-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: Typo (Re: [PATCH] i2c driver fixes for 2.6.2-rc2)
Message-ID: <20040129194705.GD5681@kroah.com>
References: <10752464532256@kroah.com> <200401281408.34364.ender@debian.org> <20040128232320.GA10657@kroah.com> <200401291227.15413.ender@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200401291227.15413.ender@debian.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 29, 2004 at 12:27:15PM +0100, David Martínez Moreno wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> El Jueves, 29 de Enero de 2004 00:23, Greg KH escribió:
> > On Wed, Jan 28, 2004 at 02:08:34PM +0100, David Martínez Moreno wrote:
> > > El Miércoles, 28 de Enero de 2004 00:34, Greg KH escribió:
> > > > +			dev_err(&adapter->dev, "Unrecgonized version/stepping 0x%02x"
> > > > +				" Defaulting to LM85.\n", verstep);
> > >
> > > 	Hello, Greg.
> > >
> > > 	Just noticed, please s,recgonized,recognized,g all over the file.
> >
> > Care to send me a spelling fix patch?
> 
> 	Sure, it's only a small thing in return for all that Linux has given to me.
> 
> 	Following patch fixes two typos and a missing full stop. Applies cleanly
> against 2.6.2-rc2 + i2c patches you just submitted.

Hm, your mailer munged the patch (due to the PGP signature), care to
redo it so that it can be applied?

thanks,

greg k-h
