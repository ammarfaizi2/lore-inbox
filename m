Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293132AbSCEOCm>; Tue, 5 Mar 2002 09:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293129AbSCEOC2>; Tue, 5 Mar 2002 09:02:28 -0500
Received: from due.stud.ntnu.no ([129.241.56.71]:18895 "EHLO due.stud.ntnu.no")
	by vger.kernel.org with ESMTP id <S293125AbSCEOCK>;
	Tue, 5 Mar 2002 09:02:10 -0500
Date: Tue, 5 Mar 2002 15:02:04 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        linux-net@vger.kernel.org
Subject: Re: [BETA-0.95] Sixth test release of Tigon3 driver
Message-ID: <20020305150204.A7174@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020305.031312.92586410.davem@redhat.com> <20020305143519.A1780@stud.ntnu.no> <20020305.055204.44939648.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020305.055204.44939648.davem@redhat.com>; from davem@redhat.com on Tue, Mar 05, 2002 at 05:52:04AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller:
> Which card do you have?

01:08.0 Ethernet controller: BROADCOM Corporation BCM5700 1000BaseTX (rev 12)
        Subsystem: Dell Computer Corporation: Unknown device 00d1
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 17
        Memory at feb00000 (64-bit, non-prefetchable) [size=64K]
        Capabilities: [40] PCI-X non-bridge device.
        Capabilities: [48] Power Management version 2
        Capabilities: [50] Vital Product Data
        Capabilities: [58] Message Signalled Interrupts: 64bit+ Queue=0/3 Enable-

That one :)

> Also, can you try both changing the MTU during the
> initial up of the interface and later after the
> interface is up already?  Thanks.

Did that, none work.

-- 
Thomas
