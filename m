Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287045AbSCEVfm>; Tue, 5 Mar 2002 16:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293662AbSCEVfc>; Tue, 5 Mar 2002 16:35:32 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:19462 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S287045AbSCEVfS>; Tue, 5 Mar 2002 16:35:18 -0500
Date: Tue, 5 Mar 2002 16:20:25 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Tim Waugh <twaugh@redhat.com>
cc: Bill Davidsen <davidsen@prodigy.com>, Mikael Pettersson <mikpe@csd.uu.se>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.4.18-pre/rc broke PLIP
In-Reply-To: <20020305165533.A1195@redhat.com>
Message-ID: <Pine.LNX.3.96.1020305155013.28458A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Mar 2002, Tim Waugh wrote:

> On Tue, Mar 05, 2002 at 11:36:59AM -0500, Bill Davidsen wrote:
> 
> >   I'm still looking at this, trying to figure out what they were trying to
> > do here...
> 
> Does 2.4.19-pre2 not work for you?

1 - didn't try, I checked that the patch had not been reverted, and
    assumed that if it was broken and not changed it was broken still.
    And I only looked in pre2-ac2, if it was fixed and Alan patched it
    back broken.
2 - understanding vast stretches of uncommented code you may need to
    change is worthwhile reading. The corolary is that comments are worthwhile
    typing.

  I'll try to build a plain 19-pre2 kernel after I do a diff with the
2.4.18 to see that something has really changed. Thanks.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

