Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271748AbRHRAND>; Fri, 17 Aug 2001 20:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271752AbRHRAMx>; Fri, 17 Aug 2001 20:12:53 -0400
Received: from ns1.system-techniques.com ([199.33.245.254]:45321 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S271748AbRHRAMp>; Fri, 17 Aug 2001 20:12:45 -0400
Date: Fri, 17 Aug 2001 20:12:45 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: "David S. Miller" <davem@redhat.com>
cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: 'make dep' produces lots of errors with this .config
In-Reply-To: <20010817.155354.85420212.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0108172010100.14013-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello Dave ,  I just barely remember a mention of a sparc pci
	capable device .  But I beleive that they were not from SUN .
	And for the life of me now I can't remember the name .
	Would you care to remind me ;-) ?  Tia ,  JimL

On Fri, 17 Aug 2001, David S. Miller wrote:
>    From: Alex Buell <alex.buell@tahallah.demon.co.uk>
>    Date: Fri, 17 Aug 2001 23:48:29 +0100 (BST)
>    That won't fix the PCI references which seems to get compiled in if
>    asm/keyboard.h is included. Taking a look at it, hmm. asm-sparc/keyboard.h
>    seems to be for the Ultra/PCI stuff, oughtn't this be in asm-sparc64, as
>    sparc32 doesn't use PCI at all, unless there's something I don't know.
> Ummm, there are most definitely PCI sparc32 systems.

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+

