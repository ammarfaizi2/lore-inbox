Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264818AbSKELgy>; Tue, 5 Nov 2002 06:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264823AbSKELgy>; Tue, 5 Nov 2002 06:36:54 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:56980 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264818AbSKELgx>; Tue, 5 Nov 2002 06:36:53 -0500
Subject: Re: [PATCH] GART driver support for generic AGP 3.0 device
	detection/ enabling & Intel 7205/7505 chipset support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Zarzycki <dave@zarzycki.org>
Cc: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'jeff@aslab.com'" <jeff@aslab.com>,
       "'greg@kroah.com'" <greg@kroah.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>,
       "Abel, Michael J" <michael.j.abel@intel.com>,
       "Tarabini, Anthony" <anthony.tarabini@intel.com>,
       "'andreasW@ati.com'" <andreasW@ati.com>,
       "Abdul-Khaliq, Rushdan" <rushdan.abdul-khaliq@intel.com>,
       "Patterson, David H" <david.h.patterson@intel.com>
In-Reply-To: <Pine.LNX.4.44.0210241713380.19133-100000@auron.zarzycki.org>
References: <Pine.LNX.4.44.0210241713380.19133-100000@auron.zarzycki.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Nov 2002 12:05:09 +0000
Message-Id: <1036497909.4791.39.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-10-25 at 01:17, Dave Zarzycki wrote:
> On Thu, 24 Oct 2002, Tolentino, Matthew E wrote:
> 
> > Attached is a patch for generic AGP 3.0 device detection and enabling
> > routines as well as specific support for the Intel E7205 and E7505 chipset
> > against the 2.4.20-pre9 kernel.   
> 
> FYI - The patch is all of the following:
> 
> 1) Zip'ed (super lame)
> 2) gziped (kinda lame, it's a small patch)
> 3) corrupt

Actually the first one was merely corrupt, the resend was fine. I've
also merged the 2.5 one into the 2.5 -ac tree.

