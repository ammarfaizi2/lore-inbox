Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283660AbRLEBik>; Tue, 4 Dec 2001 20:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283671AbRLEBia>; Tue, 4 Dec 2001 20:38:30 -0500
Received: from motgate2.mot.com ([136.182.1.10]:49842 "EHLO motgate2.mot.com")
	by vger.kernel.org with ESMTP id <S283660AbRLEBiW>;
	Tue, 4 Dec 2001 20:38:22 -0500
Date: Tue, 4 Dec 2001 19:38:20 -0600
From: Patrick E Kane <kane@urbana.css.mot.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bogus BogoMIPS on ThinkPad?  [Entertainment for Linus]
Message-ID: <20011204193820.A21774@wrangler.urbana.css.mot.com>
In-Reply-To: <200112040105.TAA16617@wrangler.urbana.css.mot.com> <Pine.LNX.4.33.0112040225500.9778-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0112040225500.9778-100000@Appserv.suse.de>; from davej@suse.de on Tue, Dec 04, 2001 at 02:28:02AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

Thanks for the pointer to tpctl (ThinkPad configuration tools for Linux).
It allowed me to change the default speed so I get 300 MHz at boot.

 || When my ThinkPad 600E boots Linux says that it has a 75 MHz CPU,
 || but my BIOS tells me it has a 300 MHz CPU -- whats the deal?
 | Try tpctl. (http://tpctl.sourceforge.net/)

Using tpctl I was able to figure out that the key sequene FN+F11 can 
be used to toggle power mode (the F11 key has faucet icon :-).

With my CPU at full speed a couple of other problems that I was having
have gone away.  I was having problems with keyboard focus when I 
switch X term windows and sometime X clients would get broken pipe
errors when starting up.

Thanks,

PEK
---
