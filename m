Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVJCRlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVJCRlZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 13:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932309AbVJCRlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 13:41:25 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:30739 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932308AbVJCRlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 13:41:24 -0400
Date: Mon, 3 Oct 2005 19:41:22 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Haninger <ahaning@gmail.com>
Cc: lokum spand <lokumsspand@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: A possible idea for Linux: Save running programs to disk
Message-ID: <20051003174122.GD3652@stusta.de>
References: <BAY105-F35A25DA28443029610815DA48E0@phx.gbl> <105c793f0510012236j16033efbh400f6f2a8495d03e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <105c793f0510012236j16033efbh400f6f2a8495d03e@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2005 at 01:36:12AM -0400, Andrew Haninger wrote:
> On 10/1/05, lokum spand <lokumsspand@hotmail.com> wrote:
> > ... a program like mozilla with many open windows. I give
> > it a SIGNAL-SAVETODISK and the process memory image is dropped to a
> > file. I can then turn off the computer and later continue using the
> > program where I left it, by loading it back into memory.
> FWIW, you can already do this with Firefox (and Mozilla, I'm sure)
> using the Sessionsaver plugin.
> 
> And while I can shed no further light on your idea, I wholeheartedly
> support it. It would be a nice alternative to swsusp/Suspend2 in that
> it could possibly avoid hardware issues involved with hibernation.

Where are hardware issues with suspend to disk?

> -Andy

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

