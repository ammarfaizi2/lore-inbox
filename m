Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281566AbRKZKut>; Mon, 26 Nov 2001 05:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281565AbRKZKuj>; Mon, 26 Nov 2001 05:50:39 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11283 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S281564AbRKZKue>; Mon, 26 Nov 2001 05:50:34 -0500
Date: Mon, 26 Nov 2001 11:50:16 +0100
From: Pavel Machek <pavel@suse.cz>
To: Patrick Cole <z@amused.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: No recording on maestro3 (hp omnibook xe3)
Message-ID: <20011126115016.F946@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011124003330.A106@elf.ucw.cz> <20011124190412.A14605@wapcaplet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011124190412.A14605@wapcaplet>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > When I do cat /dev/dsp, I get no data, and 
> > 
> > Nov 24 00:31:55 amd kernel: read: chip lockup? dmasz 65536 fragsz 64 count 0 hwptr 0 swptr 0
> > Nov 24 00:31:58 amd last message repeated 3 times
> > 
> > in the log. Is there way to help me? linux 2.4.14
> 
> Well my maestro3 works fine recording; cat /dev/dsp gives lots of rubbish.
> I have however noticed that on odd occasion it just stops working (no playing
> or nothing.. totally dead) and a reboot is required to get functionality back. 
> Anyone had this problem before? 

Yes, After few tries even recording stopped for me :-(. Reboot and all okay
								Pavel
-- 
Casualities in World Trade Center: 6453 dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
