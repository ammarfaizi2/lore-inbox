Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315275AbSF3TSW>; Sun, 30 Jun 2002 15:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315379AbSF3TSV>; Sun, 30 Jun 2002 15:18:21 -0400
Received: from unthought.net ([212.97.129.24]:65238 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S315275AbSF3TSV>;
	Sun, 30 Jun 2002 15:18:21 -0400
Date: Sun, 30 Jun 2002 21:20:46 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Ken Witherow <ken@krwtech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tyan 2460/Dual Athlon MP hangs
Message-ID: <20020630192046.GJ8557@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Ken Witherow <ken@krwtech.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0206301441230.340-200000@death>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0206301441230.340-200000@death>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 30, 2002 at 02:55:18PM -0400, Ken Witherow wrote:
> [1.] One line summary of the problem:
> Random hangs occur on dual athlon system

The 2460 systems (and many other dual athlon systems) are very sensitive
to temperature.

I'm writing this mail from a 2460 with a 62 day uptime and a load that
frequently exceeds 10.

The system I have here has a 12 cm fan (40 ltr/sec) mounted on the front
of the case for better air-intake.  This was a hardware hack we applied
after realizing the box would melt itself without some excessive
cooling.

> 
> [2.] Full description of the problem/report:
> Sometimes the system hangs during boot, sometimes at the console and
> other times while I'm in X. Happens whether or not I use the mem=nopentium
> and noapic options. Frequently, I can't catch the OOPS because I'm in X
> and everything freezes.

Can it happen during boot, if you let the system cool down for an hour
before powering it on ?

Also be sure that the PSU is big enough.


-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
