Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277918AbRKNWQP>; Wed, 14 Nov 2001 17:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278358AbRKNWQF>; Wed, 14 Nov 2001 17:16:05 -0500
Received: from relay.phys.ualberta.ca ([129.128.7.238]:15876 "EHLO
	relay.phys.ualberta.ca") by vger.kernel.org with ESMTP
	id <S277918AbRKNWPz>; Wed, 14 Nov 2001 17:15:55 -0500
Date: Wed, 14 Nov 2001 15:12:12 -0700 (MST)
From: Dmitri Pogosyan <pogosyan@Phys.UAlberta.CA>
To: <linux-kernel@vger.kernel.org>
Subject: What Athlon chipset is most stable in Linux with 3 512MB DDR modules
 ?
Message-ID: <Pine.LNX.4.30.0111141509530.879-100000@thorne>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since there is discussion of Athlon chipsets (and mainboards) and memory
is mentioned, could anybody advice me what chipset (or motherboard)
reliably supports 3 512 MB DDR modules (registered or unregistered, does
not matter) ?  I need as much memory as  possible :).

People at the shop tried to put together for me  MSI KT266 Pro2
(Via KT266a chipset) with XP 1800+ Athlon and  1.5  GB memory in 3 512
Mb modules (unregistered, non ECC, probably by Kingston) and this
configuration to pass memory stress tests they run  (BIOS detects
1.5 Gb all right, and individual modules pass the test when used one by
one in any of 3 slots).

Also I heard AMD761 also had problems with 3 high memory sticks, although
maybe not with registered one. (One mail order place refused to sell me
512 unregistered memory when I said I'll use it in Gigabyte motherboard
saying it will not work).

I'm not sure Via KT266a supports registered memory, does it ?  Manual to
MSI motherboard says  'unbuffered memory' support,   but on the memory
test site from MSI there are examples
of registered modules they run, albeight only 3x 256 MB


	Thanks in advance for advice, Dmitri



