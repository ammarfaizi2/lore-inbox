Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311460AbSCNBDc>; Wed, 13 Mar 2002 20:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311461AbSCNBDY>; Wed, 13 Mar 2002 20:03:24 -0500
Received: from CPEdeadbeef0000.cpe.net.cable.rogers.com ([24.100.234.67]:48391
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S311460AbSCNBDI>; Wed, 13 Mar 2002 20:03:08 -0500
Date: Wed, 13 Mar 2002 20:04:38 -0500 (EST)
From: Shawn Starr <spstarr@sh0n.net>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Martin Dalecki <martin@dalecki.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] PIIX rewrite patch, pre-final
In-Reply-To: <20020314001449.A31068@ucw.cz>
Message-ID: <Pine.LNX.4.40.0203132004310.7822-100000@coredump.sh0n.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This will benifit PIIX3 chipsets? :)

On Thu, 14 Mar 2002, Vojtech Pavlik wrote:

> Hi!
>
> This is a rewrite of the PIIX IDE timing driver. It should give slightly
> better performance (+4% was measured), and also replaces the slc90c66
> Efar Victory66 driver, because the Victory66 is mostly a PIIX clone.
>
> It has been tested on PIIX4 only. Please anyone with a PIIX or ICH chip,
> and if anyone has the Victory66 one even moreso, test this if you can.
>
> The patch is against 2.5.6 + the patches I sent earlier, for a complete
> patch against clean 2.5.6 see
>
> http://twilight.ucw.cz/ide-via-amd-piix-timing-8-pre-final.diff
>
> Killed code good code. :)
>
> --
> Vojtech Pavlik
> SuSE Labs
>

