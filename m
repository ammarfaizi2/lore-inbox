Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263386AbTJUU6x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 16:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263393AbTJUU6q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 16:58:46 -0400
Received: from mail.kroah.org ([65.200.24.183]:62627 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263387AbTJUU6O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 16:58:14 -0400
Date: Tue, 21 Oct 2003 13:56:53 -0700
From: Greg KH <greg@kroah.com>
To: Martin Schlemmer <azarah@gentoo.org>
Cc: clemens@dwf.com, linux-hotplug-devel@lists.sourceforge.net,
       KML <linux-kernel@vger.kernel.org>, reg@orion.dwf.com
Subject: Re: [ANNOUNCE] udev 003 release
Message-ID: <20031021205653.GA2374@kroah.com>
References: <200310171757.h9HHvGiY006997@orion.dwf.com> <20031017181923.GA10649@kroah.com> <20031017182754.GA10714@kroah.com> <1066696767.10221.164.camel@nosferatu.lan> <20031021005025.GA28269@kroah.com> <1066698679.10221.178.camel@nosferatu.lan> <20031021024322.GA29643@kroah.com> <1066707482.10221.243.camel@nosferatu.lan> <20031021174426.GA1497@kroah.com> <1066767647.11872.152.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1066767647.11872.152.camel@nosferatu.lan>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 10:20:47PM +0200, Martin Schlemmer wrote:
> > > Also, I am using ramfs for now to do the device nodes, and have not
> > > looked at minimal /dev layout, although I guess it is not that minimal,
> > > as even the input drivers lack udev (sysfs) support currently it seems.
> > > Wat was the last eta for initramfs again ?
> > 
> > initramfs is in the kernel, you use it to boot already :)
> > 
> 
> OK ... I do though remember you saying it should be possible to have
> initramfs get the initial /dev going ... any docs on that ?

Other than the source in the kernel, no, sorry.

greg k-h
