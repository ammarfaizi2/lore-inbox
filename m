Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129936AbRBSWWL>; Mon, 19 Feb 2001 17:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129987AbRBSWWB>; Mon, 19 Feb 2001 17:22:01 -0500
Received: from theirongiant.zip.net.au ([61.8.0.198]:35854 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S129983AbRBSWVw>; Mon, 19 Feb 2001 17:21:52 -0500
Date: Tue, 20 Feb 2001 09:21:06 +1100
From: CaT <cat@zip.com.au>
To: Andrey Savochkin <saw@saw.sw.com.sg>
Cc: linux-kernel@vger.kernel.org
Subject: Re: eepro100 + 2.2.18 + laptop problems
Message-ID: <20010220092106.D365@zip.com.au>
In-Reply-To: <20010211224033.G352@zip.com.au> <20010213092638.A11218@saw.sw.com.sg> <20010213151409.Q352@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010213151409.Q352@zip.com.au>; from cat@zip.com.au on Tue, Feb 13, 2001 at 03:14:09PM +1100
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2001 at 03:14:09PM +1100, CaT wrote:
> On Tue, Feb 13, 2001 at 09:26:38AM +0800, Andrey Savochkin wrote:
> > On Sun, Feb 11, 2001 at 10:40:33PM +1100, CaT wrote:
> > [snip]
> > > Feb 11 22:30:18 theirongiant kernel: eepro100: cmd_wait for(0x70) timedout with(0x70)!
> > 
> > Please try the attached patch.
> > Actually, it's designed to solve another problem, but may be your one has the
> > same origin as that other.
> 
> Cool. Thanks. I recompiled the module and am trying it now. So far the
> ethernet connection is fine but the above problem isn't reproducable with 
> 100% accuracy and so it'll take me a wee while before I decide 'oooo....
> aaaaa... that rocks my boat. it's fixed.'. :)

It happened again. Same deal. Once was after a reboot and this time
was after a resume. :/

Help?

-- 
CaT (cat@zip.com.au)		*** Jenna has joined the channel.
				<cat> speaking of mental giants..
				<Jenna> me, a giant, bullshit
				<Jenna> And i'm not mental
					- An IRC session, 20/12/2000

