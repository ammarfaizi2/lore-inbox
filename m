Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273787AbRI0SVg>; Thu, 27 Sep 2001 14:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273784AbRI0SVZ>; Thu, 27 Sep 2001 14:21:25 -0400
Received: from venus.bullseyetelecom.net ([166.90.250.12]:63759 "EHLO
	venus.bullseyetelecom.net") by vger.kernel.org with ESMTP
	id <S273781AbRI0SVP>; Thu, 27 Sep 2001 14:21:15 -0400
Subject: Re: 2.4.10 (SMP, highmem) solid freeze
From: Jason Czerak <Jason-Czerak@Jasnik.net>
To: Igor Mozetic <igor.mozetic@uni-mb.si>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15282.60654.52083.446184@proizd.camtp.uni-mb.si>
In-Reply-To: <15282.60654.52083.446184@proizd.camtp.uni-mb.si>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 27 Sep 2001 14:21:18 +0000
Message-Id: <1001600478.822.18.camel@neworder>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-09-27 at 09:10, Igor Mozetic wrote:

Yeah, same thing happened here after about 7 or 8 hours of uptime.

Dual PIII-750. 1 gig ram. supermicro P6DGE. 128 meg swap partition (just
in case). Adaptic 2490U2W

I'm dropping back to 2.4.9-ac11. that one seems to fix the high memory
bug and was stable.

Also the 2.4.10 kernel seems to slow down after a while of uptime to.
System seems sluggish. But that could be just Gnome 1.4 stuff.


> After two days of uptime under load 2-3 (no swapping, not much I/O),
> the box froze completely. Only hard reboot brought it back.
> Nothing in logs, sorry ...
> Hardware seems OK, other machines (UP, no highmem) run fine so far.
> 
> Hardware:
> dual Xeon 550Mhz, C440GX+, 2GB RAM, 1GB swap, SCSI AIC-7896/7
> 
> -Igor Mozetic
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



