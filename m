Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279814AbRJ0NRC>; Sat, 27 Oct 2001 09:17:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279816AbRJ0NQx>; Sat, 27 Oct 2001 09:16:53 -0400
Received: from app79.hitnet.RWTH-Aachen.DE ([137.226.181.79]:36362 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S279814AbRJ0NQq>;
	Sat, 27 Oct 2001 09:16:46 -0400
Date: Sat, 27 Oct 2001 15:17:19 +0200
From: Jan Niehusmann <jan@gondor.com>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA KT133 data corruption update
Message-ID: <20011027151719.A2289@gondor.com>
In-Reply-To: <1004179736.1615.19.camel@pelerin.serpentine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1004179736.1615.19.camel@pelerin.serpentine.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2001 at 03:48:56AM -0700, Bryan O'Sullivan wrote:
> After several months of begrudgingly putting up with my ASUS A7V
> motherboard corrupting roughly 1 byte per 100 million read during
> moderate to heavy PCI bus activity, I flashed VIA's 1009 BIOS this
> evening.

Please note that there have been broken versions of the 1009 BIOS
around. I know one person, and I read from serveral ones, who flashed
1009 to their A7V and were unable to start the computer afterwards.
(Hangs before/during POST).

Apparently ASUS has replaced the broken version with a working one
without updating the version number. But that's just a guess based on
recent success stories about 1009.

> I also discovered, of necessity, a halfway manageable process for
> creating a DOS boot floppy using Windows ME, which Microsoft would
> apparently prefer was not possible.  I'll reproduce the steps here,
> since otherwise flashing a new BIOS is likely to be nightmarish for
> people stuck dual booting into WinME.

As I don't use Windows at all, FreeDOS has proven very useful for 
flashing the bios. (www.freedos.org)
But, of course, no guarantees.

Jan

