Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263228AbTLDIri (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 03:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbTLDIrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 03:47:37 -0500
Received: from mail.kroah.org ([65.200.24.183]:13483 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263228AbTLDIrh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 03:47:37 -0500
Date: Wed, 3 Dec 2003 23:41:15 -0800
From: Greg KH <greg@kroah.com>
To: Fredrik Tolf <fredrik@dolda2000.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why is hotplug a kernel helper?
Message-ID: <20031204074115.GA24629@kroah.com>
References: <16334.31260.278243.22272@pc7.dolda2000.com> <20031204011357.GA22506@kroah.com> <16334.38227.433336.514399@pc7.dolda2000.com> <20031204022911.GA23761@kroah.com> <16334.44085.362449.278626@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16334.44085.362449.278626@pc7.dolda2000.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 04:38:29AM +0100, Fredrik Tolf wrote:
>  > What do you want to use the hotplug interface for that it currently does
>  > not do?
> 
> Admittedly, I'm still using the RH8 hotplug scripts, and I suspect
> improvements have been made since then. I was mainly looking for a way
> to auto-mount USB mass storage devices without having to reconfigure
> anything as root. I have all the info I need now, though.

Take a look at the devlabel package.  That should do what you are
looking for.

thanks,

greg k-h
