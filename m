Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316837AbSEVDI6>; Tue, 21 May 2002 23:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316838AbSEVDI6>; Tue, 21 May 2002 23:08:58 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:62469 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S316837AbSEVDI5>; Tue, 21 May 2002 23:08:57 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Russell King <rmk@arm.linux.org.uk>
cc: linux-kernel@vger.kernel.org
Message-ID: <86256BC1.001146A6.00@smtpnotes.altec.com>
Date: Tue, 21 May 2002 22:02:49 -0500
Subject: Re: Linux-2.5.17
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I can live with not building, crashing, or even eating filesystems.  Those
things will be fixed sooner or later.  But breaking userspace programs -- that
may well be permanent.  If there was a good chance it would be working again by
the time 2.6 comes out, it wouldn't bother me.  But I really don't expect this
to change, so it looks like I won't be able to use 2.5 (or anything later) until
I get another version of gtop, or fix this one myself.  And so there will be yet
another nonstandard change to my patchwork system that I'll have to deal with
(if I even remember it) the next time I try to upgrade (i.e., reinstall)
Slackware.





Russell King <rmk@arm.linux.org.uk> on 05/21/2002 06:29:23 PM

To:   Wayne Brown/Corporate/Altec@Altec
cc:   linux-kernel@vger.kernel.org

Subject:  Re: Linux-2.5.17



On Tue, May 21, 2002 at 06:20:56PM -0500, Wayne.Brown@altec.com wrote:
> So, I'm just getting used to the idea of using new tools to build kernels,
> and now I learn that 2.5 breaks an ordinary program that I use all day,
> every day. It just keeps getting better and better...

The 2.<odd> series, like 2.5 is a strictly development kernel series; new
features go into these all the time.  You can expect it to:

1. not build.
2. crash.
3. silently eat your filesystems.
4. break userspace programs.

or any combination of the above.  If you're looking for stability, stick
with the 2.<even> series.
--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




