Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266282AbUAVRA2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 12:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266288AbUAVRA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 12:00:28 -0500
Received: from mail.kroah.org ([65.200.24.183]:11157 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266282AbUAVRAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 12:00:24 -0500
Date: Thu, 22 Jan 2004 09:00:24 -0800
From: Greg KH <greg@kroah.com>
To: "Durairaj, Sundarapandian" <sundarapandian.durairaj@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       torvalds@osdl.org, alan@lxorguk.ukuu.org.uk,
       Andi Kleen <ak@colin2.muc.de>,
       "Kondratiev, Vladimir" <vladimir.kondratiev@intel.com>,
       "Seshadri, Harinarayanan" <harinarayanan.seshadri@intel.com>
Subject: Re: [patch] PCI Express Enhanced Config Patch - 2.6.0-test11
Message-ID: <20040122170024.GC14310@kroah.com>
References: <6B09584CC3D2124DB45C3B592414FA83011A3357@bgsmsx402.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6B09584CC3D2124DB45C3B592414FA83011A3357@bgsmsx402.gar.corp.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 03:51:22PM +0530, Durairaj, Sundarapandian wrote:
> Hi All, 
> 
> I am reposting the updated patch after incorporating the review
> comments.

Hm, looks like you have lots of comments already, so I'll wait for your
next revision before making any more about the code.

> This is the patch on PCI Express Enhanced configuration for 2.6.0 test11
> kernel following up to the Vladimir (Vladimir.Kondratiev@intel.com) and
> Harinarayanan (Harinarayanan.Seshadri@intel.com)  and my previous
> patches .
> I tested it on our i386 platform. 

If I could ask, exactly what chipset was this tested on?  I'm waist deep
in chipset specs right now, so it would be nice to see if I could try to
test this code out on something that both you have, and have not, tested
it on.

thanks,

greg k-h
