Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275011AbRIYOMm>; Tue, 25 Sep 2001 10:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275013AbRIYOMd>; Tue, 25 Sep 2001 10:12:33 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:38409 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S275011AbRIYOMW>; Tue, 25 Sep 2001 10:12:22 -0400
Date: Tue, 25 Sep 2001 18:33:57 +1000
From: john slee <indigoid@higherplane.net>
To: arjan@fenrus.demon.nl
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.10aa1 (00_vm-tweaks-1)
Message-ID: <20010925183357.E29541@higherplane.net>
In-Reply-To: <E15lH4e-0000VP-00@the-village.bc.nu> <m15lH5A-000OVWC@amadeus.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m15lH5A-000OVWC@amadeus.home.nl>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2001 at 10:46:36PM +0100, arjan@fenrus.demon.nl wrote:
> In article <E15lH4e-0000VP-00@the-village.bc.nu> you wrote:
> >> If you took my patch for it, PLEASE don't send it for inclusion; it's an
> >> evil hack and no longer needed when Intel fixes the bug in their 440GX bios.
> 
> > "when" is not a word I find useful about most bios bugs. Try "if" or
> > "less likely that being hit on the head by an asteroid"
> 
> This case is different. Intel promised the update "soon". For them it's

oh, they _promised_!  great!

on another note...

2.4.10 is great incidentally, noticeably improved performance for
a somewhat large postgresql db on raid0 (35GB, ~100 million rows)

if anyone's interested i'll post numbers vs. 2.4.9 as i do more testing.

/me bearhug andrea

j.

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
