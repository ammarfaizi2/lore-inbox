Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280898AbRKTEdh>; Mon, 19 Nov 2001 23:33:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280900AbRKTEd2>; Mon, 19 Nov 2001 23:33:28 -0500
Received: from perax6-089.dialup.optusnet.com.au ([198.142.92.89]:21518 "EHLO
	bajor.dyndns.org") by vger.kernel.org with ESMTP id <S280898AbRKTEdJ>;
	Mon, 19 Nov 2001 23:33:09 -0500
Message-ID: <3662.192.168.1.254.1006230948.squirrel@bajor.dyndns.org>
Date: Tue, 20 Nov 2001 12:35:48 +0800 (WST)
Subject: Kernel Panic on a KT133A chip set board and 2.4.14
From: "Daniel Rowe" <bart@istnet.net.au>
To: <linux-kernel@vger.kernel.org>
Reply-To: bart@istnet.net.au
X-Mailer: SquirrelMail (version 1.2.0 [rc2])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

1000mhz Athlon.KT133A MSI K7T Turbo-R Mainboard.128meg 133mhz SDRAM.
Kernel 2.4.14 with ext3 patch compiled with i386 option.
No RAID.
RedHat 7.2.
When I boot this kernel it panics and locks hard after IDE chipset init.
Cant get the output due to the hard lock. The default kernel with RH7.2
boots  and seems to run fine. "Code: Bad EIP value"

Any Ideas?

Thanks

Daniel


