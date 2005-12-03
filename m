Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbVLCSIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVLCSIV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 13:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVLCSIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 13:08:20 -0500
Received: from hell.sks3.muni.cz ([147.251.210.189]:16833 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S932116AbVLCSIU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 13:08:20 -0500
Date: Sat, 3 Dec 2005 19:07:40 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Michael Krufky <mkrufky@m1k.net>
Cc: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Re: CX8800 driver and 2.6.15-RC2
Message-ID: <20051203180740.GA11293@mail.muni.cz>
References: <20051202201408.GA11046@mail.muni.cz> <4390B0A7.8060306@m1k.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4390B0A7.8060306@m1k.net>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 03:37:59PM -0500, Michael Krufky wrote:
> Close, but no cigar ;-)
> 
> It was a memory management bug.... Already fixed in -rc3 (where new bugs 
> were introduced) ...
> 
> -rc4 isn't bad, but a whole slew of v4l / dvb bugfixes went in JUST 
> after -rc4 release...
> 
> Can you try 2.6.15-rc4-git1 and let us know how things are?

well, with 2.6.15-rc4-git video_buf related problems are gone, but it's still
far from usable. xawtv is unable to use tunner. Moreover, it seems that it
cannot get another capture format than 320x240 RGB.

-- 
Luká¹ Hejtmánek
