Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281288AbRKMAkK>; Mon, 12 Nov 2001 19:40:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281297AbRKMAj7>; Mon, 12 Nov 2001 19:39:59 -0500
Received: from theirongiant.zip.net.au ([61.8.0.198]:38369 "EHLO
	theirongiant.zip.net.au") by vger.kernel.org with ESMTP
	id <S281288AbRKMAju>; Mon, 12 Nov 2001 19:39:50 -0500
Date: Tue, 13 Nov 2001 11:38:43 +1100
From: CaT <cat@zip.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Chris Meadors <clubneon@hereintown.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: PnPBIOS (was: Re: 32-bit UID quotas?)
Message-ID: <20011113113842.K991@zip.com.au>
In-Reply-To: <Pine.LNX.4.40.0111120823210.88-100000@rc.priv.hereintown.net> <E163HJU-0005sY-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E163HJU-0005sY-00@the-village.bc.nu>
User-Agent: Mutt/1.3.23i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 01:39:48PM +0000, Alan Cox wrote:
> > I saw that ext3 is going into 2.4.15 by the testing/ChangeLog.  There are
> > also lots of Alan Cox merging, but no specific mention of whether or not
> > the 32-bit UID quota patch has gone in, or is going in.
> > 
> > The ext3 and 32-bit UID quotas were the only two patches I was really
> > relying on the -ac releases for.
> 
> 32bit uid quota is a harder one. Its probably something to be tackled after
> 2.4.15. There are a few other things like that which are lower priority 
> because they are tricky, or because (eg the kiovec stuff) they are simply
> performance boosts and can be done after we see 2.4.15 is solid
> 
> Other bits like the via timer fix are under further research

Is PnPBIOS one of these? I'm wondering when(if) it'll make it in as I'd
like to get my linux operating environment as close to the windows one
due to the laptop turning off when sound modules have been loaded (after
a while). This seems to have almost vanished in my upgrade from 2.2.19
to 2.4.xacy but it still happens occasionally.

ATM I have the BIOS set for WinME (bah) and with PnPBIOS my sound card is
given the correct IRQ instead of 0.

-- 
CaT        "As you can expect it's really affecting my sex life. I can't help
           it. Each time my wife initiates sex, these ejaculating hippos keep
           floating through my mind."
                - Mohd. Binatang bin Goncang, Singapore Zoological Gardens
