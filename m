Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269672AbRHCWyx>; Fri, 3 Aug 2001 18:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269667AbRHCWyo>; Fri, 3 Aug 2001 18:54:44 -0400
Received: from cs159246.pp.htv.fi ([213.243.159.246]:57975 "EHLO
	porkkala.cs159246.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S269658AbRHCWy3>; Fri, 3 Aug 2001 18:54:29 -0400
Message-ID: <3B6B2B9F.1CFC220A@pp.htv.fi>
Date: Sat, 04 Aug 2001 01:54:23 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Per Jessen <per.jessen@enidan.com>, linux-kernel@vger.kernel.org,
        linux-laptop@vger.kernel.org
Subject: Re: PCMCIA control I82365 stops working with 2.4.4
In-Reply-To: <3B5D8A0A002D181A@mta2n.bluewin.ch> <20010801114105.A26615@flint.arm.linux.org.uk> <3B68557B.7816FE4B@pp.htv.fi> <20010801202409.A27667@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> Hmm, I'm not an x86 expert, so I'll have to leave you here.  What I do 
> know is that yenta is for PCI-based PCMCIA controllers with CardBus 
> support. i82365 is for ISA PCMCIA controllers only.

The machine has CardBus (at least CB-logo beside slots). It's Toshiba
Satellite 300CDS.

 - Jussi Laako

--- 8< ---
00:00.0 Host bridge: Toshiba America Info Systems 601 (rev 2c)
00:04.0 VGA compatible controller: Chips and Technologies F65555 HiQVPro
(rev c6)
00:0b.0 USB Controller: NEC Corporation USB (rev 02)
00:11.0 Communication controller: Toshiba America Info Systems FIR Port (rev
21)
00:13.0 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 20)
00:13.1 CardBus bridge: Toshiba America Info Systems ToPIC97 (rev 20)
--- 8< ---

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
