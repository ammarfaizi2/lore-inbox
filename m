Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315942AbSFPGfz>; Sun, 16 Jun 2002 02:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSFPGfy>; Sun, 16 Jun 2002 02:35:54 -0400
Received: from adsl-216-62-201-136.dsl.austtx.swbell.net ([216.62.201.136]:58767
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S315942AbSFPGfx>; Sun, 16 Jun 2002 02:35:53 -0400
Subject: Re: Dual Athlon 2000 XP MP nightmare
From: Austin Gonyou <austin@digitalroadkill.net>
To: Hugh <hugh@nospam.com>
Cc: linux-kernel@vger.kernel.org, coles@vip.kos.netDear
In-Reply-To: <3D0BE1AC.3080202@nospam.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 16 Jun 2002 01:35:02 -0500
Message-Id: <1024209302.26299.4.camel@UberGeek>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It does most sound like some mis-behaving kernel code. No hard locks it
sounds like...but kernel panics and no joy. I'd for sure recommend KDB
for this chore, it will at least shed light on the misbehaving piece.

On Sat, 2002-06-15 at 19:54, Hugh wrote:
> Dear Steve, Richard, and others,
> 
> >I'm not sure that what I'm experiencing is a kernel problem, but I >thought
> >I would stick my foot in the door nonetheless, since I have no real
> >indication of what is going on.
> >
....
> 
> That was when I returned the motherboard the second time.
> The first time, the board gave me a CMOS error.   The third time, the
> board even did not give me the first beep.  I now think that I should
> have bought the Tyan board instead of the ASUS.
> 
> Regards,
> 
> G. Hugh Song
> 
> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>
