Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267449AbRHKMWy>; Sat, 11 Aug 2001 08:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266914AbRHKMWe>; Sat, 11 Aug 2001 08:22:34 -0400
Received: from 195-23-114-51.nr.ip.pt ([195.23.114.51]:50816 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267579AbRHKMWc>; Sat, 11 Aug 2001 08:22:32 -0400
Date: Sat, 11 Aug 2001 13:21:10 +0100 (WEST)
From: Rui Sousa <rui.p.m.sousa@clix.pt>
X-X-Sender: <rsousa@localhost.localdomain>
To: Daniel Bertrand <d.bertrand@ieee.org>
cc: <linux-kernel@vger.kernel.org>,
        emu10k1-devel <emu10k1-devel@opensource.creative.com>
Subject: Re: [Emu10k1-devel] [PATCH] emu10k1 againt kernel 2.4.8
In-Reply-To: <Pine.LNX.4.33.0108110000300.32369-100000@kilrogg>
Message-ID: <Pine.LNX.4.33.0108111318420.847-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Aug 2001, Daniel Bertrand wrote:

Are there any "beginner" instructions for the tools?
Will you be mantaining this tarball? If so we can point people
there from "Configure.help".

Rui Sousa
> Hi,
>
> Here's an 'emergency' tarball of the userland tools to go with it:
>
> http://opensource.creative.com/~dbertrand/emu-tools-0.9.tar.gz
>
>
>
>
> On Sat, 11 Aug 2001, Rui Sousa wrote:
>
> >
> > Patch against kernel 2.4.8:
> > 1. Fixes makefiles changes (can now be compiled as a module).
> > 2. Reverts addition of joystick.c
> > 3. Enables emu10k1 sequencer support.
> > 4. Adds documentation for the driver new features.
> >
> > Please apply,
> >
> > Rui Sousa
> >
>
>

-- 
Rui Sousa

