Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261246AbSKBPEf>; Sat, 2 Nov 2002 10:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261258AbSKBPEf>; Sat, 2 Nov 2002 10:04:35 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:38282 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261246AbSKBPEc>; Sat, 2 Nov 2002 10:04:32 -0500
Subject: Re: What's left over.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.3.96.1021101235904.29692B-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1021101235904.29692B-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Nov 2002 15:30:27 +0000
Message-Id: <1036251027.16803.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-02 at 05:00, Bill Davidsen wrote:
> > Linus I've asked a couple of times about killing sound/oss off now ALSA
> > is integrated 8) While you are on the rant how about that ;)
> 
> Good point, that continues to disprove the theory that having one thing in
> the kernel prevents development of a similar feature.

Its preventing testing and its making parallel fixing hard to manage.
I'd really like to kill off the OSS drivers to make sure the ALSA ones
are tested and anything only in OSS does get ported over,


