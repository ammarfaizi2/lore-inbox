Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267153AbTBIC2P>; Sat, 8 Feb 2003 21:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267155AbTBIC2P>; Sat, 8 Feb 2003 21:28:15 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58896 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267153AbTBIC2N>; Sat, 8 Feb 2003 21:28:13 -0500
Date: Sat, 8 Feb 2003 18:34:08 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roland McGrath <roland@redhat.com>
cc: Anton Blanchard <anton@samba.org>, <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@digeo.com>,
       <arjanv@redhat.com>
Subject: Re: heavy handed exit() in latest BK
In-Reply-To: <200302090231.h192Vlc04229@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.44.0302081833290.7675-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 8 Feb 2003, Roland McGrath wrote:
> 
> I'm already in the midst of those and will test my various cases and gdb
> and so forth.  If you want to put something in before I've done testing,
> then please send me the patch you use.

You just got it. HOWEVER, I haven't actually committed it to my tree, and 
I might as well wait for your test results, so you can choose to just 
ignore it if you want to.

		Linus

