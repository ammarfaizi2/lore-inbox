Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275983AbRJBJr6>; Tue, 2 Oct 2001 05:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275990AbRJBJrs>; Tue, 2 Oct 2001 05:47:48 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:61457 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S275983AbRJBJrh>; Tue, 2 Oct 2001 05:47:37 -0400
Date: Tue, 2 Oct 2001 11:48:01 +0200
From: Pavel Machek <pavel@suse.cz>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Matti Aarnio <matti.aarnio@zmailer.org>,
        Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>,
        linux-kernel@vger.kernel.org
Subject: Re: Ethernet Error Correction
Message-ID: <20011002114801.A19015@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010925223437.A21831@atrey.karlin.mff.cuni.cz> <20010926004345.D11046@mea-ext.zmailer.org> <20010927142251.A58@toy.ucw.cz> <20011002112921.A7117@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011002112921.A7117@suse.cz>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > 	Also, generic PROMISC mode still drops off received frames
> > > 	with CRC error.
> > 
> > Hmm, sounds good. Someone should create tool for communication over
> > ethernet with broken crc's. Such communication would be stealth from
> > normal tcpdump. Do it on your provider's network to escape accounting ;^)
> 
> But still you'll see the number of errors on your eth card
> skyrocketing, so you'd grow quite suspicious. 

Yep, but it would be _very_ hard for you to find the cause. You'd
probably chase ghosts trying to replace cables, etc, never finding
what happens.


							Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
