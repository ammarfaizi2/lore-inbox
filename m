Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261402AbSKBSWK>; Sat, 2 Nov 2002 13:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265908AbSKBSWJ>; Sat, 2 Nov 2002 13:22:09 -0500
Received: from mail2.sonytel.be ([195.0.45.172]:47771 "EHLO mail.sonytel.be")
	by vger.kernel.org with ESMTP id <S261402AbSKBSVD>;
	Sat, 2 Nov 2002 13:21:03 -0500
Date: Sat, 2 Nov 2002 19:23:09 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Joel Becker <Joel.Becker@oracle.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Bill Davidsen <davidsen@tmr.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
In-Reply-To: <Pine.LNX.4.44.0211012003290.2206-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0211021922040.12247-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Nov 2002, Hugh Dickins wrote:
> I dealt with crash dumps quite a lot over 10 years with SCO UNIX,
> OpenServer and UnixWare: which were addressing the PC market, not
> own hardware.
> 
> It's a real worry that writing a crash dump to disk might stomp in the
> wrong place, but I don't recall it ever happening in practice.  But
> occasionally, yes, a dump was not generated at all, or not completed.

IIRC, some years ago wuarchive.wustl.edu went down for a few days because the
machine paniced and dumped to the wrong partition...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

