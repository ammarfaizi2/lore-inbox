Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131239AbRCMWxL>; Tue, 13 Mar 2001 17:53:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131237AbRCMWxB>; Tue, 13 Mar 2001 17:53:01 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:42253 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S131236AbRCMWwm>; Tue, 13 Mar 2001 17:52:42 -0500
Date: Tue, 13 Mar 2001 14:51:28 -0800
To: Pete Toscano <pete.lkml@toscano.org>, David DeGeorge <dld@degeorge.org>,
        linux-kernel@vger.kernel.org
Subject: Re: APIC  usb MPS 1.4 and the 2.4.2 kernel
Message-ID: <20010313145128.A15637@ferret.phonewave.net>
In-Reply-To: <200103130245.f2D2j2J01057@janus.local.degeorge.org> <20010313002513.A1664@bubba.toscano.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010313002513.A1664@bubba.toscano.org>; from pete.lkml@toscano.org on Tue, Mar 13, 2001 at 12:25:13AM -0500
From: idalton@ferret.phonewave.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2001 at 12:25:13AM -0500, Pete Toscano wrote:
> Well, I can't speak for the consequences of noapic (I've wondered as
> much myself), but I know that there's been a problem with SMP 2.4
> kernels (even the 2.4 test kernels) and USB running on VIA chipsets for
> a while now.  I'm told by the linux-usb maintainers that it's a problem
> with the PCI IRQ routing for the VIA chipsets, but I've been unable to
> get anyone who knows about this to do anything (and I've been asking for
> a while).  Alas, since this stuff is beyond me, I just accept the fact
> that it'll probably always be broke.

I have the same problem with my Triton II dual-pentium 200 system, for
what it's worth.

-- Ferret



