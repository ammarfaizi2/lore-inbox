Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129114AbRBCR60>; Sat, 3 Feb 2001 12:58:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129145AbRBCR6Q>; Sat, 3 Feb 2001 12:58:16 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:15741 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129114AbRBCR6I>; Sat, 3 Feb 2001 12:58:08 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200102031756.f13Hu4s13521@devserv.devel.redhat.com>
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
To: acahalan@cs.uml.edu (Albert D. Cahalan)
Date: Sat, 3 Feb 2001 12:56:04 -0500 (EST)
Cc: dwmw2@infradead.org (David Woodhouse), alan@redhat.com (Alan Cox),
        reiser@namesys.com (Hans Reiser), mason@suse.com (Chris Mason),
        kas@informatics.muni.cz (Jan Kasprzak), linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com,
        yura@yura.polnet.botik.ru (Yury Yu. Rupasov)
In-Reply-To: <200102031733.f13HXUo463110@saturn.cs.uml.edu> from "Albert D. Cahalan" at Feb 03, 2001 12:33:29 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> David Woodhouse writes:
> 
> >  -a "$CC" = "gcc"
> 
> Not worth it; they should upgrade the local gcc too.
> If anything, they are getting a reminder that they need.

The local gcc has no bearing on the compiler. The local compiler might not 
even be gcc - eg if they are cross building off non Linux systems

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
