Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292410AbSBZR3b>; Tue, 26 Feb 2002 12:29:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292418AbSBZR3W>; Tue, 26 Feb 2002 12:29:22 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:15626 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288967AbSBZR3N>;
	Tue, 26 Feb 2002 12:29:13 -0500
Date: Tue, 26 Feb 2002 09:22:51 -0800
From: Greg KH <greg@kroah.com>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        linux-net@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
Message-ID: <20020226172251.GA32073@kroah.com>
In-Reply-To: <20020225.165914.123908101.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020225.165914.123908101.davem@redhat.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 29 Jan 2002 14:26:54 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just wanted to say thanks for doing this work, the driver works great
for me for this device:

01:04.0 Ethernet controller: BROADCOM Corporation NetXtreme BCM5700 Gigabit Ethernet (rev 12)
        Subsystem: BROADCOM Corporation NetXtreme BCM5700 1000BaseTX
        Flags: bus master, 66Mhz, medium devsel, latency 240, IRQ 42
        Memory at f0e00000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-

But I'm only able to run it at 10Mbit :)

thanks,

greg k-h
