Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271479AbRHQQeq>; Fri, 17 Aug 2001 12:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271684AbRHQQe2>; Fri, 17 Aug 2001 12:34:28 -0400
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:9220 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S271479AbRHQQeM>;
	Fri, 17 Aug 2001 12:34:12 -0400
Date: Fri, 17 Aug 2001 09:34:56 -0700 (PDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Holger Lubitz <h.lubitz@internet-factory.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Encrypted Swap
In-Reply-To: <3B7D3EF9.4CEABF2C@internet-factory.de>
Message-ID: <Pine.LNX.4.10.10108170932030.1944-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Aug 2001, Holger Lubitz wrote:

> "Richard B. Johnson" proclaimed:
> 
> > Errrm no. All BIOS that anybody would use write all memory found when
> > initializing the SDRAM controller. They need to because nothing,
> > refresh, precharge, (or if you've got it, parity/crc) will work
> > until every cell is exercised. A "warm-boot" is different. However,
> > if you hit the reset or the power switch, nothing in RAM survives.
> 
> Then this may have changed with SDRAM. However, back in my Amiga days it
> was pretty common to just reset the machine and rip whatever was left in
> the memory (DRAM). If memory serves me right, some people put in reset
> protection (by pointing the reset vector to some code that cleared the
> memory), which could be fooled by hardware reset or power cycling.
> 

My Apple IIc's manual recommended waiting 15 seconds before turning the
machine back on in order to wait for the memory to clear.  I wonder how
long SDRAM lasts if actually removed instead of letting the BIOS clear it
on boot.

	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

