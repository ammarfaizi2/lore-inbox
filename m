Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317911AbSFNMkR>; Fri, 14 Jun 2002 08:40:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317910AbSFNMkQ>; Fri, 14 Jun 2002 08:40:16 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:3847 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317909AbSFNMkP>; Fri, 14 Jun 2002 08:40:15 -0400
Date: Fri, 14 Jun 2002 08:34:30 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: "Jason C. Pion" <jpion@valhalla.homelinux.org>
cc: Nick Evgeniev <nick@octet.spb.ru>, Andre Hedrick <andre@linux-ide.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.19-preX IDE bugs
In-Reply-To: <Pine.LNX.4.44.0206111243560.2457-100000@valhalla.homelinux.org>
Message-ID: <Pine.LNX.3.96.1020614082716.9892C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002, Jason C. Pion wrote:


> It sounds to me like you've got some flakey hardware.  Don't try to save 
> the rest of us.  I've been using the Promise drivers with my Ultra 133TX2 
> for quite a while now and haven't had _ANY_ problems with it.  I've used 
> all of the 2.4.19preXX kernels so far with now issues.  This "problem" 
> isn't as wide-spread as you think.

Clearly *any* problem which only happens with SMP isn't as wide-spread,
and if you are running uni then there should not be a problem. Given that
earlier and later similar chipset have a sticky bit and no problem, I
think it would be reasonable to protect people in a stable kernel. If the
config file needed to be patched and there were a warning on the next
line, that would certainly assure they knew they were taking a risk.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

