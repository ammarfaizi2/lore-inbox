Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276225AbRI1SbI>; Fri, 28 Sep 2001 14:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276230AbRI1Sa7>; Fri, 28 Sep 2001 14:30:59 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:23820 "EHLO
	deathstar.prodigy.com") by vger.kernel.org with ESMTP
	id <S276225AbRI1Sak>; Fri, 28 Sep 2001 14:30:40 -0400
Date: Fri, 28 Sep 2001 14:31:08 -0400
Message-Id: <200109281831.f8SIV8706610@deathstar.prodigy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi driver trouble in ac15
X-Newsgroups: linux.dev.kernel
In-Reply-To: <3BB469E1.9090205@juridicas.com>
Organization: TMR Associates, Schenectady NY
From: davidsen@tmr.com (bill davidsen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BB469E1.9090205@juridicas.com> jnerin@juridicas.com wrote:

	[ ide-scsi problens ]

>It also happened to me with ac10, ide-scsi, CD-RW is a Samsung 8x, and =
>I=20
>was writing a audio cd, when it finished writing the track 8 of 18 it=20
>entered the loop, since then I couldn't eject the cd, neither eject=20
>/dev/hdb, nor cdrecord -eject, nor the eject button, I had to reboot.
>
>My system is a 2x200mmx smp all ide.

Don't see it on a P-II-400 (Dell Dimension 400). The Yamaha on-board
sound doesn't work, but it never did, it just thinks it is, sound apps
work fine but never produce output.

I do note that the sound modules noted in modules.conf didn't load and
need to be hand loaded...

-- 
bill davidsen <davidsen@tmr.com>
 "If I were a diplomat, in the best case I'd go hungry.  In the worst
  case, people would die."
		-- Robert Lipe
