Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261247AbVELEFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261247AbVELEFH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 00:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVELEFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 00:05:07 -0400
Received: from picard.ine.co.th ([203.152.41.3]:19114 "EHLO picard.ine.co.th")
	by vger.kernel.org with ESMTP id S261247AbVELEFA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 00:05:00 -0400
Subject: Re: kernel (64bit) 4GB memory support
From: Rudolf Usselmann <rudi@asics.ws>
Reply-To: rudi@asics.ws
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Frank Denis (Jedi/Sector One)" <j@pureftpd.org>,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <4282D3E1.80303@stesmi.com>
References: <20041216074905.GA2417@c9x.org> <1103213359.31392.71.camel@cpu0>
	 <Pine.LNX.4.61.0412201246180.12334@montezuma.fsmlabs.com>
	 <1103646195.3652.196.camel@cpu0>
	 <Pine.LNX.4.61.0412210930280.28648@montezuma.fsmlabs.com>
	 <1103647158.3659.199.camel@cpu0>
	 <Pine.LNX.4.61.0412210955130.28648@montezuma.fsmlabs.com>
	 <1115654185.3296.658.camel@cpu10>
	 <20050509200721.GE2297@csclub.uwaterloo.ca>
	 <1115754522.4409.16.camel@cpu10>
	 <20050511142745.GQ2281@csclub.uwaterloo.ca>  <4282D3E1.80303@stesmi.com>
Content-Type: text/plain
Organization: ASICS.ws - Solutions for your ASICS & FPGA needs -
Date: Thu, 12 May 2005 11:04:53 +0700
Message-Id: <1115870693.8406.53.camel@cpu10>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-12 at 05:56 +0200, Stefan Smietanowski wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Lennart Sorensen wrote:
> > On Wed, May 11, 2005 at 02:48:42AM +0700, Rudolf Usselmann wrote:
> > 
> >>I do see the full 4G. With Fedora Core 2 32bit, I can use all
> >>4G as well. All my problems started when I "upgraded" to x86_64 ...
> > 
> > 
> > In 32bit it probably uses the PSE36 extensions or something, which isn't
> > the same thing as flat 64bit memory access.  It could just be a matter
> > of needing a memory hole somewhere for PCI space or something.  I only
> > have 1G in my 64bit machine so I haven't got near these problems.
> 
> I don't recall him saying he's changed kernel from the default redhat
> kernel in which case he's running the RedHat 4G/4G split kernel and not
> using PSE/PAE.
> 
> // Stefan


I'm using whatever is available on www.kernerl.org :*)

Sorry I am totally lost what the above terminology means.

Is that a configuration option that I should try, or a totally
different branch of the kernel ?

Thanks !
rudi
=============================================================
Rudolf Usselmann,  ASICS World Services,  http://www.asics.ws
Your Partner for IP Cores, Design, Verification and Synthesis

