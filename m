Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262728AbRE0Cz1>; Sat, 26 May 2001 22:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262729AbRE0CzS>; Sat, 26 May 2001 22:55:18 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:2512 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S262728AbRE0CzJ>;
	Sat, 26 May 2001 22:55:09 -0400
Message-ID: <3B106C88.A2A763C8@mandrakesoft.com>
Date: Sat, 26 May 2001 22:55:04 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jonathan Morton <chromi@cyberspace.org>
Cc: cesar.da.silva@cyberdude.com, kernellist <linux-kernel@vger.kernel.org>
Subject: Re: Please help me fill in the blanks.
In-Reply-To: <20010527021808.80979.qmail@web13407.mail.yahoo.com> <l03130309b7361b2c0bc8@[192.168.239.105]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Morton wrote:
> 
> >> * Live Upgrade
> >
> >LOBOS will let one Linux kernel boot another, but that requires a boot
> >step, so it is not a live upgrade.  so, no, afaik
> 
> If you build nearly everything (except, obviously what you need to boot) as
> modules, you can unload modules, build new versions, and reload them.  So,
> you could say that partial support for "live upgrades" is included.

I stand corrected, though I clearly know better:
Modules are unloaded/reloaded all the time during my driver development
:)

-- 
Jeff Garzik      | Disbelief, that's why you fail.
Building 1024    |
MandrakeSoft     |
