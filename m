Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291562AbSBHMiW>; Fri, 8 Feb 2002 07:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291563AbSBHMiM>; Fri, 8 Feb 2002 07:38:12 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:22798 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291562AbSBHMh6>; Fri, 8 Feb 2002 07:37:58 -0500
Date: Fri, 8 Feb 2002 13:37:55 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Pavel Machek <pavel@suse.cz>, Dave Jones <davej@suse.de>,
        kernel list <linux-kernel@vger.kernel.org>, vojtech@ucw.cz,
        andre@linuxdiskcert.org
Subject: Re: ide cleanup
Message-ID: <20020208133755.A10250@suse.cz>
In-Reply-To: <20020206205332.GA3217@elf.ucw.cz> <3C63C5EF.4050403@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C63C5EF.4050403@evision-ventures.com>; from dalecki@evision-ventures.com on Fri, Feb 08, 2002 at 01:34:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 01:34:55PM +0100, Martin Dalecki wrote:
> 
> >Hi!
> >
> >IDE is
> >* infested with polish notation
> >
> I don't see any polish notation there. Could you please explain what you 
> mean with this note?

I think Pavel meant what I think is called "hungarian notation", adding
_t's to type identifiers or adding _i or i_ to integer variables.

> Other then this - the patch does good.... BTW. There is the issue of
> multiple block strategy routines in ide-disk.c and the selection of 16
> ver. 32 bit transfers could be simplified as well, since the
> particular code in question is blatantly over-optimized.

-- 
Vojtech Pavlik
SuSE Labs
