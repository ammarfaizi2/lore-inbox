Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267621AbSKSXXb>; Tue, 19 Nov 2002 18:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267623AbSKSXXa>; Tue, 19 Nov 2002 18:23:30 -0500
Received: from [198.144.200.85] ([198.144.200.85]:45189 "EHLO
	synapse.neuralscape.com") by vger.kernel.org with ESMTP
	id <S267621AbSKSXXY>; Tue, 19 Nov 2002 18:23:24 -0500
Date: Tue, 19 Nov 2002 15:30:59 -0800
From: Karen Shaeffer <shaeffer@neuralscape.com>
To: linux-kernel@vger.kernel.org
Subject: Prism 2.5 Wavelan chipset
Message-ID: <20021119153059.A5143@synapse.neuralscape.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I have an IBM A31 with the pci bus Prism 2.5 Wavelan chipset (rev 01) that
supports 802.11b wireless. I've googled around for quite awhile but am not
convinced I have answered my questions.

I have wireless up and running on the laptop with a 2.4.19 kernel. It's a
red hat 8.0 distribution on the computer. But there is some indication from
my google searches that this Prism 2.5 based system won't perform well with
the mainstream kernel's orinoco driver. Folks suggest the wlan-ng driver from 

http://www.linux-wlan.com/linux-wlan/

I'd like to stick with the main kernel code. I see in the kernel archives
that there are related patches going into the 2.5.x kernel. Which kernel
version is best suited for my needs? 

Finally, I have installed a pci to pcmcia converter and an orinoco gold
pcmcia card on a pc that I want to use to establish an access point with.
Does the kernel currently support this? If so, what version?

Thank you for any comments.

cheers,
Karen
-- 
 Karen Shaeffer
 Neuralscape; Santa Cruz, Ca. 95060
 shaeffer@neuralscape.com  http://www.neuralscape.com
