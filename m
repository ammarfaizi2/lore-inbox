Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280939AbRKCLFP>; Sat, 3 Nov 2001 06:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280940AbRKCLFF>; Sat, 3 Nov 2001 06:05:05 -0500
Received: from jabberwock.ucw.cz ([212.71.128.53]:3859 "EHLO jabberwock.ucw.cz")
	by vger.kernel.org with ESMTP id <S280939AbRKCLFC>;
	Sat, 3 Nov 2001 06:05:02 -0500
Date: Sat, 3 Nov 2001 12:04:55 +0100
From: Martin Mares <mj@ucw.cz>
To: Greg Sheard <greg@ecsc.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Intel chipset development documents
Message-ID: <20011103120455.B676@ucw.cz>
In-Reply-To: <1004721050.20610.7.camel@lemsip> <20011102183829.A31651@atrey.karlin.mff.cuni.cz> <1004735023.21120.12.camel@lemsip>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1004735023.21120.12.camel@lemsip>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I already have the configuration type down (it's 1), but the 430VX and
> also the VIA 585 seem only to report host bridges. I'm unable to spot
> the piece of code which does different PCI-related things for these
> chipsets in the kernel. Does anybody know if a workaround is applied?

It's quite strange -- can you send me 'lspci -vvx -MH1' output, please?

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
"Beware of bugs in the above code; I have only proved it correct, not tried it." -- D.E.K.
