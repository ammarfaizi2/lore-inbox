Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261410AbTCOLYZ>; Sat, 15 Mar 2003 06:24:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261412AbTCOLYZ>; Sat, 15 Mar 2003 06:24:25 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6670 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261410AbTCOLYY>; Sat, 15 Mar 2003 06:24:24 -0500
Date: Sat, 15 Mar 2003 11:35:11 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Patches Patches Patches
Message-ID: <20030315113511.A2883@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just setup

	http://patches.arm.linux.org.uk/

which contains a collection of patches pending for testing and/or Linus'
tree.  This currently includes:

	- PCI 1 through PCI 19
	- PCIPS2 (for Mobility Electronics EV1000 docking station)
	- PCMCIA 2 through PCMCIA 7b
	- Serial 1 through Serial 17

Unfortunately, the serial changes are just too big to be mailed through
this mailing list.  I have also tacked on in serial-17.diff the patch
which should have been accepted by Linus before serial-1 through
serial-16.diff, but was completely ignored.  Also, pci-6.diff contains
the fix that prevents PPC machines from crashing, which was also
completely ignored.

Please note that there are some inter-dependencies between the PCI
patches after pci-15.diff which will break the kernel build currently.

Each subdirectory contains a readme describing each of the patches.

Please note that from time to time, patches may be re-ordered and updated
so please don't read too much into the patch filenames.

Enjoy.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

