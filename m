Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbSJPVbI>; Wed, 16 Oct 2002 17:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261429AbSJPVbI>; Wed, 16 Oct 2002 17:31:08 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:65284 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S261426AbSJPVbG>;
	Wed, 16 Oct 2002 17:31:06 -0400
Date: Wed, 16 Oct 2002 23:36:49 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Matt Domsch <Matt_Domsch@Dell.com>
Cc: rob@osinvestor.com, linux-kernel@vger.kernel.org
Subject: Re: Watchdog drivers
Message-ID: <20021016233648.A7786@medelec.uia.ac.be>
References: <20021014184031.A19866@medelec.uia.ac.be> <Pine.LNX.4.44.0210141408400.13924-100000@humbolt.us.dell.com> <20021015192615.A1512@medelec.uia.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021015192615.A1512@medelec.uia.ac.be>; from wim@iguana.be on Tue, Oct 15, 2002 at 07:26:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

> Ok, I compared your patches againts mine and they were almost identical. :-)
> After some more coding I have now a first set of patches to get everything
> moved and to add the missing watchdog drivers. Next patches will contain
> updates on the documentation and on each driver seperatly. 
> 
> The first patches are:
> Patch 1 : move of existing watchdog drivers in drivers/char/watchdog/
> Patch 2 : remove of 'old' watchdog drivers in drivers/char/
> Patch 3 : cleanup additional spaces in headers + addition of MODULE-info
> Patch 4 : C99 designated initializers for watchdog drivers
> Patch 5 : add extra watchdog drivers
> 
> If you want to test them you can get them at the following URL:
> http://medelec.uia.ac.be/linux/watchdog/ .

Since there seems to be a problem with web-traffic to the server, I changed 
the location of the patches. They are now at:
ftp://medelec.uia.ac.be/pub/linux/kernel-patches/

Greetings,
Wim.

