Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261520AbTC3Tbe>; Sun, 30 Mar 2003 14:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261521AbTC3Tbe>; Sun, 30 Mar 2003 14:31:34 -0500
Received: from [195.39.17.254] ([195.39.17.254]:10500 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261520AbTC3Tbe>;
	Sun, 30 Mar 2003 14:31:34 -0500
Date: Fri, 28 Mar 2003 12:19:45 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Peter T. Breuer" <ptb@it.uc3m.es>
Cc: Justin Cormack <justin@street-vision.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ENBD for 2.5.64
Message-ID: <20030328111945.GC5147@zaurus.ucw.cz>
References: <1048623613.25914.14.camel@lotte> <200303252053.h2PKrRn09596@oboe.it.uc3m.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303252053.h2PKrRn09596@oboe.it.uc3m.es>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>   9) it drops into a mode where it md5sums both ends and skips writes
>   of equal blocks, if that's faster. It moves in and out of this mode
>   automatically. This helps RAID resyncs (2* overspeed is common on
>   100BT nets, that is 20MB/s.).

Great way to find md5 collisions, I guess
:-).
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

