Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267322AbSLEXks>; Thu, 5 Dec 2002 18:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267375AbSLEXks>; Thu, 5 Dec 2002 18:40:48 -0500
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:60850
	"HELO mail.theoesters.com") by vger.kernel.org with SMTP
	id <S267322AbSLEXkr>; Thu, 5 Dec 2002 18:40:47 -0500
Date: Thu, 5 Dec 2002 15:48:22 -0800
From: Phil Oester <kernel@theoesters.com>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: "David S. Miller" <davem@redhat.com>,
       Bingner Sam J Contractor PACAF CSS/SCHE 
	<Sam.Bingner@hickam.af.mil>,
       "'ja@ssi.bg'" <ja@ssi.bg>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: hidden interface (ARP) 2.4.20
Message-ID: <20021205154822.A6762@ns1.theoesters.com>
References: <A6B0BFA3B496A24488661CC25B9A0EFA333DEF@himl07.hickam.pacaf.ds.af.mil> <1039124530.18881.0.camel@rth.ninka.net> <20021205140349.A5998@ns1.theoesters.com> <3DEFD845.1000600@drugphish.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DEFD845.1000600@drugphish.ch>; from ratz@drugphish.ch on Thu, Dec 05, 2002 at 11:50:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 11:50:45PM +0100, Roberto Nibali wrote:
> First I would like to ask people not to post such patches to lkml but 
> rather to the LVS list, because this affects only LVS so far and we 

*snip*

Eh?  Last I checked, there were other loadbalancing solutions out there.  Some
even use hardware (like ours).  IOW - LVS isn't the only use for the hidden flag.

This flag is useful for many folks, and is a generic (not LVS specific) kernel feature
which many of us would like to see added back to the kernel.

Granted, further discussion on the matter is an exercise in futility, as the current
net maintainer has already stated his disdain for it.  So...we'll go on patching
our kernels ad infinitum.

-Phil
