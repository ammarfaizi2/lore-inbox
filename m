Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu id <157561-2781>; Fri, 8 Jan 1999 11:33:20 -0500
Received: from stimpy.netroedge.com ([207.109.249.50]:13333 "EHLO Stimpy.netroedge.com" ident: "phil") by vger.rutgers.edu with ESMTP id <160365-2781>; Thu, 7 Jan 1999 19:06:46 -0500
Date: Thu, 7 Jan 1999 18:34:50 -0800 (PST)
From: <phil@Stimpy.netroedge.com>
To: linux-kernel@vger.rutgers.edu
cc: linux-kernel-announce@vger.rutgers.edu, linux-apps@vger.rutgers.edu
Subject: Hardware Health Monitoring
Message-ID: <Pine.LNX.3.96.990107180901.31905B-100000@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-kernel@vger.rutgers.edu



This is an announcement of the latest stable release of lm_sensors version
2.1.1.  Lm_sensors is a package which allows your Linux kernel to
communicate with various hardware health monitoring chips (if your
mainboard is so equipped) to find out such things as temperatures, supply
voltages, fan speeds, etc. 

For more info and downloads:

http://www.netroedge.com/~lm78

Chips supported (as of this writing): LM78, LM78J, LM79, LM80, W83781,
GL518, LM75, ISA based interfaces, Intel PIIX4 SMBus interfaces, Via
south-bridge I2C interfaces, serial SMBus/I2C EEPROMs (on SDRAM DIMMs and
in Xeon Processors), and more. 

This software is a must for unsupervised Linux machines such as servers,
routers, embedded Linux devices, etc.

Lm_sensors is under a GNU-type usage license.


Philip Edelbrock
phil@netroedge.com
Lm_sensors Development Group
http://www.netroedge.com/~lm78


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
