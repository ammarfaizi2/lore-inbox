Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266627AbTA1O1K>; Tue, 28 Jan 2003 09:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266310AbTA1O1K>; Tue, 28 Jan 2003 09:27:10 -0500
Received: from users.linvision.com ([62.58.92.114]:14799 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S266627AbTA1O0N>; Tue, 28 Jan 2003 09:26:13 -0500
Date: Tue, 28 Jan 2003 15:35:19 +0100
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Wichert Akkerman <wichert@wiggy.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Bootscreen
Message-ID: <20030128153519.A14150@bitwizard.nl>
References: <Pine.LNX.4.44.0301281113480.20283-100000@schubert.rdns.com> <200301281144.h0SBi0ld000233@darkstar.example.net> <20030128114840.GV4868@wiggy.net> <1043758528.8100.35.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1043758528.8100.35.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2003 at 12:55:29PM +0000, Alan Cox wrote:
> The real question is whether you want to do this in the kernel or simply at
> the moment the kernel flips to user space. An init can easily open vt2,
> draw a pretty boot screen with something like nanogui or bogl and then 
> continue to spew the text to vt1 so anyone can see the text messages if
> need be.

An ATM here in delft showed 

	OS/2 booting

and all the BIOS stuff when I once caught it in the act of booting...

				Rogier. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
