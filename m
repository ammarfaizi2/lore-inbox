Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266368AbSKUGzs>; Thu, 21 Nov 2002 01:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266369AbSKUGzs>; Thu, 21 Nov 2002 01:55:48 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:3456 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S266368AbSKUGzr>; Thu, 21 Nov 2002 01:55:47 -0500
Date: Thu, 21 Nov 2002 18:01:57 +1100
From: CaT <cat@zip.com.au>
To: Jaroslav Kysela <perex@perex.cz>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.48 and ALSA
Message-ID: <20021121070157.GA696@zip.com.au>
References: <20021119133959.GA818@zip.com.au> <Pine.LNX.4.33.0211191509540.503-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0211191509540.503-100000@pnote.perex-int.cz>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2002 at 03:10:41PM +0100, Jaroslav Kysela wrote:
> > CONFIG_SND_DUMMY=y
> 
> Remove this dummy driver, it does nothing.

Gah! I feel silly now. I had that when using modules so that things
would stop complaining about not having audio when I didn't want it on
(it usually brings down my laptop in a heap - instant off). Am trying
now with the new ALSA drivers and 2.5.x to see if they do thesame or
not. So far so good (ie no shutdowns). :)

BTW. Should having the Mic volume way-up result in a highly piched tone
being emitted from the speakers? I don't remember this ever being the
case before. (had this happen this morning when I turned the laptop on -
nice way to -really- wake up)

-- 
        All people are equal,
        But some are more equal then others.
            - George W. Bush Jr, President of the United States
              September 21, 2002 (Abridged version of security speech)
