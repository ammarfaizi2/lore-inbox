Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129552AbQLVSgr>; Fri, 22 Dec 2000 13:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129870AbQLVSgi>; Fri, 22 Dec 2000 13:36:38 -0500
Received: from chaos.analogic.com ([204.178.40.224]:14976 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129552AbQLVSgd>; Fri, 22 Dec 2000 13:36:33 -0500
Date: Fri, 22 Dec 2000 13:05:47 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Stephen Torri <s.torri@lancaster.ac.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Transmission errors for Xircom RealPort2 10/100 Cardbus NIC.
In-Reply-To: <Pine.LNX.4.21.0012221649060.1705-100000@mobile.torri.linux>
Message-ID: <Pine.LNX.3.95.1001222130431.2200A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2000, Stephen Torri wrote:

> I am having a real interesting time with the Xircom card and
> kernel-2.2.16. All transmission packets from the NIC are being flagged for
> errors while all received packets are fine. The card is in a Twinhead
> P88TE Cardbus PCMCIA slot. Eradicate errors like total packet loss, 1
> packet out of 4 returning fine with ping, and others are causing me to be
> concerned. The module I am using is tulip_cb.

Update your `ifconfig`. It's just reading the wrong stuff.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.0 on an i686 machine (799.54 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
