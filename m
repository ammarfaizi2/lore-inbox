Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263295AbUFNQ14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263295AbUFNQ14 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 12:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263340AbUFNQ14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 12:27:56 -0400
Received: from mail.kroah.org ([65.200.24.183]:6308 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263295AbUFNQ1y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 12:27:54 -0400
Date: Mon, 14 Jun 2004 09:26:38 -0700
From: Greg KH <greg@kroah.com>
To: Dominik Karall <dominik.karall@gmx.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: 2.6.7-rc3-mm2
Message-ID: <20040614162638.GA25769@kroah.com>
References: <20040614021018.789265c4.akpm@osdl.org> <200406141620.01731.dominik.karall@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406141620.01731.dominik.karall@gmx.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 04:19:52PM +0200, Dominik Karall wrote:
> On Monday 14 June 2004 11:10, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7-rc3/2.6
> >.7-rc3-mm2/
> 
> I got following messages on startup of hotplug:
> usb 3-1: control timeout on ep0in
> usb 3-1: string descriptor 0 read error: -110
> usb 3-1: string descriptor 0 read error: -110

Do you get these same errors on a clean 2.6.7-rc3?

thanks,

greg k-h
