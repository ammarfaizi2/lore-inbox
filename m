Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131290AbRCNECZ>; Tue, 13 Mar 2001 23:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131300AbRCNECF>; Tue, 13 Mar 2001 23:02:05 -0500
Received: from odin.sinectis.com.ar ([216.244.192.158]:4103 "EHLO
	mail.sinectis.com.ar") by vger.kernel.org with ESMTP
	id <S131290AbRCNEB4>; Tue, 13 Mar 2001 23:01:56 -0500
Date: Wed, 14 Mar 2001 01:03:35 -0300
From: John R Lenton <john@grulic.org.ar>
To: linux-kernel@vger.kernel.org
Cc: Pete Toscano <pete.lkml@toscano.org>, Greg KH <greg@wirex.com>
Subject: Re: APIC  usb MPS 1.4 and the 2.4.2 kernel
Message-ID: <20010314010335.C18554@grulic.org.ar>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Pete Toscano <pete.lkml@toscano.org>, Greg KH <greg@wirex.com>
In-Reply-To: <200103130245.f2D2j2J01057@janus.local.degeorge.org> <20010313002513.A1664@bubba.toscano.org> <20010313092837.A805@wirex.com> <20010313124954.B5626@bubba.toscano.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010313124954.B5626@bubba.toscano.org>; from pete.lkml@toscano.org on Tue, Mar 13, 2001 at 12:49:54PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2001 at 12:49:54PM -0500, Pete Toscano wrote:
> Very interesting.  I had not heard about this.  Are there any SMP boards
> with a VIA chipset that does work well with Linux and USB?  I have an
> old P2B-DS that I had replace with this board as I needed more PCI
> slots.  Heck, for that matter are there any SMP boards that work well
> with Linux and USB that have six or more PCI slots?

My 694D Pro (MS-6321) has been working fine once I got the heat
problem off my hands. USB works, as long as the MPS is set at
1.1. It's a SMP board with VIA's "Apollo Pro133A" chipset, and
the vt82c686a.

-- 
John Lenton (john@grulic.org.ar) -- Random fortune:
I matematici lo fanno in teoria, oppure lo portano al limite.
