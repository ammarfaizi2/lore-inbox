Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281450AbRKTWoS>; Tue, 20 Nov 2001 17:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281453AbRKTWoI>; Tue, 20 Nov 2001 17:44:08 -0500
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:43505 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S281450AbRKTWnw>; Tue, 20 Nov 2001 17:43:52 -0500
Message-ID: <59885C5E3098D511AD690002A5072D3C42D772@orsmsx111.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'\"ChristianK.\"@t-online.de'" <"ChristianK."@t-online.de>,
        linux-kernel@vger.kernel.org
Subject: RE: Again Multiboot-Standard for Linux ?
Date: Tue, 20 Nov 2001 14:43:42 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> From: "ChristianK."@t-online.de [mailto:"ChristianK."@t-online.de]

> Is anyone still working on making the Linux Kernel Multiboot 
> compliant ?

Was someone working on this before? It didn't seem like it.

> I wan't to load my modules from grub(pxegrub) without the 
> need to compile in 
> ramdisk / initrd / romfs... (System memory is very low (4MB-6MB)).

I am tentatively looking at this, but for other reasons. IIRC the initrd's
memory is recycled later on, so I don't know if tight memory is a good
reason for pursuing this.

Regards -- Andy
