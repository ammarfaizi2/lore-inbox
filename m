Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbTIPMSv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 08:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbTIPMSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 08:18:51 -0400
Received: from ns.suse.de ([195.135.220.2]:59114 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261850AbTIPMSu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 08:18:50 -0400
Date: Tue, 16 Sep 2003 14:18:48 +0200
From: Olaf Hering <olh@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: =?utf-8?Q?Dani=C3=ABl?= Mantione <daniel@deadlock.et.tudelft.nl>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       "David S. Miller" <davem@redhat.com>, mroos@linux.ee,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: atyfb still broken on 2.4.23-pre4 (on sparc64)
Message-ID: <20030916121848.GA9897@suse.de>
References: <Pine.LNX.4.44.0309152320130.24675-100000@deadlock.et.tudelft.nl> <1063663632.585.61.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1063663632.585.61.camel@gaston>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Sep 16, Benjamin Herrenschmidt wrote:

 
> There are a few PPC machines for which atyfb is "critical":

>  - Beige G3 (older XL iirc)

this one works, but they use different chips.

atyfb: using auxiliary register aperture
atyfb: 3D RAGE (GT) [0x4754 rev 0x9a] 2M SGRAM, 14.31818 MHz XTAL, 200 MHz PLL, 67 Mhz MCLK, 67 Mhz XCLK
atyfb: monitor sense=737, mode 5
Console: switching to colour frame buffer device 80x30
fb0: ATY Mach64 frame buffer device on PCI
MacOS display is /pci/ATY,mach64_3DU


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
