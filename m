Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129819AbQK1Qjr>; Tue, 28 Nov 2000 11:39:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129818AbQK1Qjh>; Tue, 28 Nov 2000 11:39:37 -0500
Received: from astrid2.nic.fr ([192.134.4.2]:18695 "EHLO astrid2.nic.fr")
        by vger.kernel.org with ESMTP id <S129819AbQK1QjU>;
        Tue, 28 Nov 2000 11:39:20 -0500
Date: Tue, 28 Nov 2000 16:33:05 +0000
From: Francois romieu <romieu@ensta.fr>
To: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: test-10 tulip "eth0 timed out" (smp, heavy IDE use)
Message-ID: <20001128163305.A785@nic.fr>
Reply-To: Francois romieu <romieu@ensta.fr>
In-Reply-To: <20001128042134.A1041@twoey> <200011280952.eAS9qkb01700@lt.wsisiz.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200011280952.eAS9qkb01700@lt.wsisiz.edu.pl>; from lukasz@lt.wsisiz.edu.pl on Tue, Nov 28, 2000 at 10:52:46AM +0100
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The Tue, Nov 28, 2000 at 10:52:46AM +0100, Lukasz Trabinski wrote :
[...]
> I have the same problem with SMSC EPIC/100 83c170 Ethernet controller:
> 
> NETDEV WATCHDOG: eth0: transmit timed out
> eth0: Transmit timeout using MII device, Tx status 0003.
> eth0: Restarting the EPIC chip, Rx 4568454/4568454 Tx 6262613/6262623.
> eth0: epic_restart() done, cmd status 000a, ctl 0512 interrupt 240000.

Could you describe a way to reproduce it or be more specific regarding
the hardware/load/whatever ?

-- 
Ueimor
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
