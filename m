Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264799AbSLLOGI>; Thu, 12 Dec 2002 09:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264818AbSLLOGI>; Thu, 12 Dec 2002 09:06:08 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:53697 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S264799AbSLLOGH>; Thu, 12 Dec 2002 09:06:07 -0500
Message-ID: <3DF898C7.6030301@oracle.com>
Date: Thu, 12 Dec 2002 15:10:15 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.5[01]]: Xircom Cardbus broken (PCI resource collisions)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As per subject - my RBEM56G-100BTX isn't usable due to the reasons
  printed in /var/log/messages. This has already been reported but
  I don't recall seeing patches or any debug stuff to be tried

[...]

NET4: Linux TCP/IP 1.0 for NET4.0
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 32768)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
cs: cb_alloc(bus 2): vendor 0x115d, device 0x0003
PCI: Device 02:00.0 not available because of resource collisions
PCI: Device 02:00.1 not available because of resource collisions
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.

[...]

--alessandro

  "Seems that you can't get any more than half free"
        (Bruce Springsteen, "Straight Time")

