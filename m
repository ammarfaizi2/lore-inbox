Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269989AbRHEShH>; Sun, 5 Aug 2001 14:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269987AbRHESg5>; Sun, 5 Aug 2001 14:36:57 -0400
Received: from cs159246.pp.htv.fi ([213.243.159.246]:3913 "EHLO
	porkkala.cs159246.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S269986AbRHESgo>; Sun, 5 Aug 2001 14:36:44 -0400
Message-ID: <3B6D921E.B5EFB98@pp.htv.fi>
Date: Sun, 05 Aug 2001 21:36:14 +0300
From: Jussi Laako <jlaako@pp.htv.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: bvermeul@devel.blackstar.nl
CC: Russell King <rmk@arm.linux.org.uk>, Per Jessen <per.jessen@enidan.com>,
        linux-kernel@vger.kernel.org, linux-laptop@vger.kernel.org
Subject: Re: PCMCIA control I82365 stops working with 2.4.4
In-Reply-To: <Pine.LNX.4.33.0108041122520.15321-100000@devel.blackstar.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bvermeul@devel.blackstar.nl wrote:
> 
> > > Try going to your bios and setting the PCMCIA adapter to 
> > > Cardbus/16bit instead of Auto. The Toshiba Topic chipsets are buggy, 
> > Dunno how to change those. The machine had just windows based setup 
> > program.
> Press Esc when the laptop boots. It'll tell you you did something stupid,
> and please press F1 to enter setup.

OK, I changed that and now it works fine. :)

> My Dell Inspiron 8000 (Ati video chipset) works flawlessly for me. Got
> everything working like it should.

IrDA also?


 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
