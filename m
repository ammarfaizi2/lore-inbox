Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129199AbRBGWT3>; Wed, 7 Feb 2001 17:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129434AbRBGWTI>; Wed, 7 Feb 2001 17:19:08 -0500
Received: from chaos.analogic.com ([204.178.40.224]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S129199AbRBGWTG> convert rfc822-to-8bit; Wed, 7 Feb 2001 17:19:06 -0500
Date: Wed, 7 Feb 2001 17:18:11 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Gérard Roudier <groudier@club-internet.fr>
cc: davej@suse.de, Alan Cox <alan@redhat.com>, becker@scyld.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Hamachi not doing pci_enable before reading resources
In-Reply-To: <Pine.LNX.4.10.10102072135320.905-100000@linux.local>
Message-ID: <Pine.LNX.3.95.1010207171646.249A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Feb 2001, [ISO-8859-1] Gérard Roudier wrote:

> 
> You missed the newer statements about every piece of hardware being
> assumed to be hot-pluggable and all the hardware being under full control
> by CPU.
> 
> You also missed the well known point that only device drivers are broken
> under Linux and that all the generic O/S code is just perfect. :-)
> 
>   Gérard.
> 

Yep. I missed a lot. When the next 'release' comes out, I'll have
to rewrite all my drivers again --sigh...

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
