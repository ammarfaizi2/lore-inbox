Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271000AbRHYHPe>; Sat, 25 Aug 2001 03:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271063AbRHYHPY>; Sat, 25 Aug 2001 03:15:24 -0400
Received: from cp26357-a.gelen1.lb.nl.home.com ([213.51.0.86]:61796 "HELO
	lunchbox.oisec.net") by vger.kernel.org with SMTP
	id <S271000AbRHYHPM>; Sat, 25 Aug 2001 03:15:12 -0400
Date: Sat, 25 Aug 2001 09:15:17 +0200
From: Cliff Albert <cliff@oisec.net>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx errors with 2.4.8-ac7 on 440gx mobo
Message-ID: <20010825091517.B18300@oisec.net>
In-Reply-To: <20010820230410.A28323@oisec.net> <200108202144.f7KLiYY43268@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200108202144.f7KLiYY43268@aslan.scsiguy.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2001 at 03:44:34PM -0600, Justin T. Gibbs wrote:

> >And here they are, the dmesg is my bootup dmesg with the devices drivers 
> >and stuff, and the second dmesg is the actual errors (verbose turned on)
> 
> You need OFOJ or better firmware in your Fireball ST.  The firmware you
> have now is known to be bad.  Before Maxtor's purchase of Quantum's
> disk line, you used to be able to get firmware updates off of
> ftp.quantum.com, but they've hence cleared out those files.  In a
> quick look through Maxtor's site, I could not find the relevant files.

Actually my scsi errors disappeared all when i upgraded my P2B-S motherboard
to bios version 1014 Beta 1A (which inclused adaptec bios v3.10). It's available
from ftp.asuscom.de

-- 
Cliff Albert		| RIPE:	     CA3348-RIPE | www.oisec.net
cliff@oisec.net		| 6BONE:     CA2-6BONE	 | icq 18461740
