Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269673AbRHCXEe>; Fri, 3 Aug 2001 19:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269669AbRHCXEZ>; Fri, 3 Aug 2001 19:04:25 -0400
Received: from cs159246.pp.htv.fi ([213.243.159.246]:18843 "EHLO
	porkkala.cs159246.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S269667AbRHCXEU>; Fri, 3 Aug 2001 19:04:20 -0400
Message-ID: <3B6B2DC4.B13B4B1@pp.htv.fi>
Date: Sat, 04 Aug 2001 02:03:32 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: bvermeul@devel.blackstar.nl
CC: Russell King <rmk@arm.linux.org.uk>, Per Jessen <per.jessen@enidan.com>,
        linux-kernel@vger.kernel.org, linux-laptop@vger.kernel.org
Subject: Re: PCMCIA control I82365 stops working with 2.4.4
In-Reply-To: <Pine.LNX.4.33.0108012139330.31291-100000@devel.blackstar.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bvermeul@devel.blackstar.nl wrote:
> 
> Try going to your bios and setting the PCMCIA adapter to Cardbus/16bit
> instead of Auto. The Toshiba Topic chipsets are buggy, change their PCI

Dunno how to change those. The machine had just windows based setup program.

> identifiers with different bios settings, and are just a plain pain in 
> the ass to get working. Then use the yenta driver (preferrably in 
> kernel), and I think you will find it works now. :)

I wonder why it stopped working, because it was working just fine until
lately. I don't care if it's CardBus or old ISA-based PCMCIA because it
makes no difference as long as it works. I've been using it for years with
Linux and FreeBSD.

> Bas Vermeulen, who has had some bad experiences with Toshiba laptops. And
> it's impossible to get specs for em too.

Btw. is there any completely working laptop? I've got lot of problems with
Dell and IBM laptops. I've really started to hate all this mobile stuff that
never works...


Best regards,

	- Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
