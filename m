Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264352AbRF1VmP>; Thu, 28 Jun 2001 17:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264407AbRF1VmG>; Thu, 28 Jun 2001 17:42:06 -0400
Received: from ns.guardiandigital.com ([209.11.107.5]:33808 "HELO
	juggernaut.dmz.guardiandigital.com") by vger.kernel.org with SMTP
	id <S264352AbRF1Vl7>; Thu, 28 Jun 2001 17:41:59 -0400
Date: Thu, 28 Jun 2001 17:41:57 -0400 (EDT)
From: "Ryan W. Maple" <ryan@guardiandigital.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jussi Laako <jlaako@pp.htv.fi>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: VIA 686B/Data Corruption
In-Reply-To: <E15FjMG-0007g0-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10106281741070.11750-100000@mastermind.inside.guardiandigital.com>
X-Base: ALL YOUR BASE ARE BELONG TO US. (http://www.scene.org/redhound/AYB.swf)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001, Alan Cox wrote:

> > Just tested RedHat's 2.4.3-12 and 2.4.5-ac19 on A7V133 mobo. RedHat's kernel
> > seems to work without lockups, but 2.4.5-ac19 doesn't (locks up at boot,
> > compiled w/o athlon optimization and ACPI), so no changes on that.
> 
> Interesting. They should be the same code for the VIA driver.

I remember hearing something about Red Hat disabling UDMA on VIA chips
across the board.  Maybe that has something to do with it?

-r

