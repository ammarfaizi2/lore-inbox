Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273043AbRIRR1b>; Tue, 18 Sep 2001 13:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273028AbRIRR1W>; Tue, 18 Sep 2001 13:27:22 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:1783 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S273027AbRIRR1N>; Tue, 18 Sep 2001 13:27:13 -0400
Message-ID: <8FB7D6BCE8A2D511B88C00508B68C20819717B@orsmsx102.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: linux-kernel@vger.kernel.org
Subject: RE: Whats in the wings for 2.5 (when it opens)
Date: Tue, 18 Sep 2001 10:23:03 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

unified device tree (for power management)
changing all drivers to support the above.

This stuff isn't the kind of thing that's ready to go beforehand - we need
to get the device tree infrastructure in place, and then we can attack the
drivers.

Regards -- Andy

> From: Ed Tomlinson [mailto:tomlins@cam.org]
> Seems like there is a lot of code "ready" for consideration 
> in a 2.5 kernel.
> I can think of:
> 
> premptable kernel option
> user mode kernel 
> jfs
> xfs (maybe)
> rc2
> reverse maping vm
> ide driver rewrite
> 32bit dma
> LTT (maybe)
> LVM update to 1.01
> ELVM (maybe)
> module security stuff
> UP friendly SMP scheduler
> 
> What else?
> 
> TIA
> Ed Tomlinson
