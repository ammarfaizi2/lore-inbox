Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261778AbSI2Tz3>; Sun, 29 Sep 2002 15:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261777AbSI2Tz2>; Sun, 29 Sep 2002 15:55:28 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:56542 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S261776AbSI2Tz0>;
	Sun, 29 Sep 2002 15:55:26 -0400
Date: Sun, 29 Sep 2002 22:00:49 +0200
From: bert hubert <ahu@ds9a.nl>
To: Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: qsbench, interesting results
Message-ID: <20020929200049.GA6460@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Lorenzo Allegrucci <l.allegrucci@tiscalinet.it>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <200209291615.24158.l.allegrucci@tiscalinet.it> <20020929162627.GA1270@outpost.ds9a.nl> <200209292156.35518.l.allegrucci@tiscalinet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209292156.35518.l.allegrucci@tiscalinet.it>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2002 at 09:56:35PM +0200, Lorenzo Allegrucci wrote:

> >Furthermore, can you check how much
> > lowmem is actually available according to the dmesg output? It may be that
> > your graphics adaptor is using ram in one kernel but not in another.
> 
> The memory available is about the same in all tests, and all
> tests have been run in single user mode.

Can you then provide people with 'vmstat 1' output while your program runs?

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
