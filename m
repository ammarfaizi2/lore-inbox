Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131457AbRC3NxX>; Fri, 30 Mar 2001 08:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131455AbRC3NxN>; Fri, 30 Mar 2001 08:53:13 -0500
Received: from tomts7.bellnexxia.net ([209.226.175.40]:44766 "EHLO
	tomts7-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131459AbRC3NxF>; Fri, 30 Mar 2001 08:53:05 -0500
Date: Fri, 30 Mar 2001 08:52:08 -0500
From: Tim Coleman <tim@epenguin.org>
To: linux-kernel@vger.kernel.org
Subject: RTL8139 conflicting with hard drive?
Message-ID: <20010330085208.A428@tux.epenguin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-PGP-Key: finger tim@beastor.epenguin.org
X-Operating-System: Linux 2.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a problem with a NIC I tried to install this morning.
The chip on the NIC says its an RTL-8139B (it's a generic brand
NIC, and I didn't really need anything fancy).

When I install the NIC, and try to boot, the kernel complains
about not being able to find the root device.  If I take it out,
everything is fine.  I'm using kernel version 2.4.1, and my 
motherboard is an Asus A7V.  

I already have one RTL-8139B NIC installed, and it's just fine.

I also noticed that the kernel seemed to detect it as an IDE
controller, because two more IDE devices showed up in the boot
messages.

What could cause this?  More importantly, what's a good remedy?

-- 
Tim Coleman <tim@epenguin.org>                         [43.28 N 80.31 W]
Software Developer/Systems Administrator/RDBMS Specialist/Linux Advocate
University of Waterloo Honours Co-op Combinatorics & Optimization
"Go to Heaven for the climate, Hell for the company." -- Mark Twain

