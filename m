Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261782AbTCGVJQ>; Fri, 7 Mar 2003 16:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261784AbTCGVJQ>; Fri, 7 Mar 2003 16:09:16 -0500
Received: from 101.24.177.216.inaddr.g4.Net ([216.177.24.101]:38543 "EHLO
	sparrow.stearns.org") by vger.kernel.org with ESMTP
	id <S261782AbTCGVJO>; Fri, 7 Mar 2003 16:09:14 -0500
Date: Fri, 7 Mar 2003 16:19:41 -0500 (EST)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: alx <alx@autistici.org>
cc: ML-linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: acx100_pci.o GPL but only binary version
In-Reply-To: <1047068240.1604.11.camel@galileo.homenet.lan>
Message-ID: <Pine.LNX.4.44.0303071606450.3395-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, (alx?),

On 7 Mar 2003, alx wrote:

> I got this module from the net (binary version)
> 
> acx100_pci.o wanna be a linux driver from the TI acx100 chipset.
> but it doesn't work at all!
> - First ifconfig SegFault 
> - Second hangs the machine
> 
> I did modinfo on this module and I got:
> 
>  $ modinfo acx100_pci.o
> filename:    acx100_pci.o
> description: "TI ACX100 WLAN 22Mbps driver"
> author:      "Lancelot Wang"
> license:     "GPL"
>  $
> 
> Someone has the source code or know the author ?

	The module appears to have come from:
http://vilos.com/650_plus/ .  Have you contacted the administrator of that 
web server and asked how to reach the author?

Vilos.com:
   Administrative Contact:
      Johanson, Eric  ericj@cubesearch.com
      3659 22nd Ave W
      Suite 4
      Seattle, WA  98199
      US
      206-xxx-xxxx

	A Google search on "Lancelot Wang" ACX100 provides some 
discussion.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Do what you love, and love what you do, and you will never work
another day in your life."
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
Linux articles at:                         http://www.opensourcedigest.com
--------------------------------------------------------------------------

