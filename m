Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUJVRc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUJVRc3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUJVR1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:27:09 -0400
Received: from daffy.napanet.net ([206.81.96.18]:47119 "EHLO mx1.napanet.net")
	by vger.kernel.org with ESMTP id S266888AbUJVRSx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:18:53 -0400
Date: Fri, 22 Oct 2004 10:15:29 -0700
From: Stephen Lewis <lewis@napanet.net>
To: linux-kernel@vger.kernel.org
Subject: Re: HARDWARE: Open-Source-Friendly Graphics Cards -- Viable?
Message-Id: <20041022101529.732254eb.lewis@napanet.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.8; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Miller wrote:

> The reason this idea came up is because I, as a user of Linux, am often 
> frustrated by the lack of open-source support for graphics cards which
> are not "pre-owned".  Sure, SOME companies release specs so that we can 
> develop open source drivers, but those cards tend to be prohibitively 
> expensive, slower than their cheaper counterparts from ATI or nVidia, 
> and they STILL don't document the internals of the BIOS so that the card 
> can be ported to a non-x86 system.

What has this to do with the kernel? More relevant on X server, OpenGL or GPGPU lists?

Baseline - I can get accelerated 3D graphics and video overlay
and YV12 and VGA registers with open source driver that compiles
for PowerPC and DEC Alpha today for $85 - Radeon 7500 PCI. 
X.org 'ati' driver at http://x.org
http://freedesktop.org/cgi-bin/viewcvs.cgi/xc/programs/Xserver/hw/xfree86/drivers/ati/?root=xorg
If you can improve on that then I will buy one for each of my Alpha and PowerPC systems.

http://www.gpgpu.org/ are programming multivendor graphics cards for
general purpose computing BUT the toolchain involves a proprietary
compiler which is single platform.
What good is a card with open source hardware and open source
driver that is programmable BUT the toolchain is proprietary?

Stephen Lewis
