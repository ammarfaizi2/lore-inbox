Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWAIOWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWAIOWp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 09:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWAIOWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 09:22:45 -0500
Received: from herkules.vianova.fi ([194.100.28.129]:2688 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S932218AbWAIOWo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 09:22:44 -0500
Date: Mon, 9 Jan 2006 16:22:39 +0200
From: Ville Herva <vherva@vianova.fi>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <tapas@affenbande.org>,
       Tomasz =?iso-8859-1?Q?K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       Adrian Bunk <bunk@stusta.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Takashi Iwai <tiwai@suse.de>, Olivier Galibert <galibert@pobox.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, Andi Kleen <ak@suse.de>,
       perex@suse.cz, alsa-devel@alsa-project.org, James@superbug.demon.co.uk,
       sailer@ife.ee.ethz.ch, linux-sound@vger.kernel.org, zab@zabbo.net,
       kyle@parisc-linux.org, jgarzik@pobox.com,
       Thorsten Knabe <linux@thorsten-knabe.de>, zwane@commfireservices.com,
       zaitcev@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Message-ID: <20060109142239.GR21365@vianova.fi>
Reply-To: vherva@vianova.fi
References: <20060104010123.GK3831@stusta.de> <Pine.BSO.4.63.0601040242190.29027@rudy.mif.pg.gda.pl> <20060104113726.3bd7a649@mango.fruits.de> <1136445395.24475.17.camel@mindpipe> <20060105124317.2d12a85c@mango.fruits.de> <1136483330.31583.5.camel@mindpipe> <20060108210756.GD1686@vianova.fi> <1136756669.2997.2.camel@mindpipe> <20060109081646.GG21365@vianova.fi> <1136814731.9957.4.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136814731.9957.4.camel@mindpipe>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 08:52:11AM -0500, you [Lee Revell] wrote:
> 
> Sure, we'd like the bug report.  

I will try to come up with one.

> I just wanted to point out that many people who tell everyone that "ALSA
> sucks" like you and JWZ, have really just made the mistake of buying
> bleeding edge barely-supported hardware.

Yes.

I'll happily admit I definetely made just that mistake.

Before I bought the new card, I did some quick asking around, and heard that
M-Audio was supposedly good. I just wanted better sound quality than the
integrated I815 sound (shouldn't be much to ask), and preferably HW mixing.
I checked that revo7.1 was supported, but when I went to the reseller, they
were out of stock for that one. So I made a quick and unconsidered decision
to buy revo5.1 instead.

So it was definetely bad research on my part. 

But I still maintain that the asoundrc required for swmixing is not as
trivial as "just works". It wasn't even with i815 audio.
 
> If vendors gave us more docs so that reverse engineering drivers was not
> the norm, the situation would improve greatly.

I understand.



-- v -- 

v@iki.fi

