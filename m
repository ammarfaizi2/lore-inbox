Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261685AbTCGRdV>; Fri, 7 Mar 2003 12:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261690AbTCGRdV>; Fri, 7 Mar 2003 12:33:21 -0500
Received: from B12a0.pppool.de ([213.7.18.160]:21376 "EHLO solfire")
	by vger.kernel.org with ESMTP id <S261685AbTCGRdU>;
	Fri, 7 Mar 2003 12:33:20 -0500
Date: Fri, 07 Mar 2003 16:19:42 +0100 (MET)
Message-Id: <20030307.161942.41631717.mccramer@s.netic.de>
To: Nicolas.Mailhot@one2team.com
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
From: Meino Christian Cramer <mccramer@s.netic.de>
In-Reply-To: <1047046315.7172.8.camel@ulysse.olympe.o2t>
References: <1047046315.7172.8.camel@ulysse.olympe.o2t>
X-Mailer: Mew version 3.2 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
X-SA-Exim-Rcpt-To: Nicolas.Mailhot@one2team.com, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: 2.5.64p5 No USB support when APIC mode enabled
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Mailhot <Nicolas.Mailhot@one2team.com>
Subject: Re: 2.5.64p5 No USB support when APIC mode enabled
Date: 07 Mar 2003 15:11:56 +0100

Hi,

 I got "No dma on first hard drive" as bug id 15 ???
 As that, what you intended, Nicolas ???

 Keep hacking!
 Meino

> |Alan Cox wrote :
> |
> |You need at least 2.4.21-pre5-ac, or 2.5.64-ac (I just sent Linus the
> |relevant changes) to use APIC on the VIA chipset systems. You also need
> |a BIOS with correct tables, which can also be a little tricky to find
> |in uniprocessordom
> 
> Well, if it's the same bug as 
> http://bugzilla.kernel.org/show_bug.cgi?id=15, 
> I'm certainly seeing it also with 2.5.64-ac1. Old 2.4.-ac kernels used to be
> fine, I fear they have nowe been "fixed" to match 2.5.
> 
> Maybe you should be cc'd on this bug ?
> 
> |And Meino Christian Cramer replied :
> |
> | Therefore it seems that APIC is working with my VIA board without USB.
> | But I cannot live without USB ... my mouse is USBish and X without a
> | mouse is a little ... hmmm senseless.
> 
> Lucky you. I'm on a 100% hid input setup (mouse *and* keyboard), the 
> hardware is great on the kernels that support it, but is seems good
> Linux support is not here yet:(.
> 
> Regards,
> 
> -- 
> Nicolas Mailhot
