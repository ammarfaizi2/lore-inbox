Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261460AbSKNDVU>; Wed, 13 Nov 2002 22:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261451AbSKNDVP>; Wed, 13 Nov 2002 22:21:15 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.11.87]:3332
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S261460AbSKNDUM>; Wed, 13 Nov 2002 22:20:12 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: [COMPILE ERROR]: 2.5.46,47 - In Function acpi_system_suspend
Date: Wed, 13 Nov 2002 22:32:17 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200211132232.17723.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A7M266-D Athlon MP 2000+ (BIOS 1009 release)

drivers/built-in.o(.text+0x28fae): In function `acpi_system_suspend':
: undefined reference to `do_suspend_lowlevel'
make: *** [.tmp_vmlinux1] Error 1


This occurs when enabling "Sleep States" for ACPI.

Shawn.
