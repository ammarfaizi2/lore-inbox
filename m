Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130580AbRBCArZ>; Fri, 2 Feb 2001 19:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130481AbRBCArP>; Fri, 2 Feb 2001 19:47:15 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:1807 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S130354AbRBCArF>; Fri, 2 Feb 2001 19:47:05 -0500
From: Andre Pang <andrep@cse.unsw.edu.au>
To: alex@foogod.com
Date: Sat, 3 Feb 2001 11:40:18 +1100
Cc: Hans Reiser <reiser@namesys.com>, Alan Cox <alan@redhat.com>,
        John Morrison <john@vmlinux.net>, Chris Mason <mason@suse.com>,
        Jan Kasprzak <kas@informatics.muni.cz>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com,
        "Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>
Subject: Re: [reiserfs-list] Re: ReiserFS Oops (2.4.1, deterministic, symlink
Message-ID: <20010203114018.A21761@cse.unsw.edu.au>
Mail-Followup-To: alex@foogod.com, Hans Reiser <reiser@namesys.com>,
	Alan Cox <alan@redhat.com>, John Morrison <john@vmlinux.net>,
	Chris Mason <mason@suse.com>,
	Jan Kasprzak <kas@informatics.muni.cz>,
	linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
	"Yury Yu. Rupasov" <yura@yura.polnet.botik.ru>
In-Reply-To: <200102022139.f12LdII21148@devserv.devel.redhat.com> <3A7B2E94.F52C4342@namesys.com> <20010202145814.L19961@draco.foogod.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20010202145814.L19961@draco.foogod.com>; from alex@foogod.com on Fri, Feb 02, 2001 at 02:58:14PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2001 at 02:58:14PM -0800, alex@foogod.com wrote:

> Now, it seems to me, as long as the ReiserFS folks are going to be getting the 
> bulk of the extra work(/mail/whatever) out of this, and they've been advised 
> of the risks to their own person and are ok with that (which they apparently 
> are), then they might as well go ahead and try it.  It's their inboxes.

okay, i don't really want to prolong this debate any longer, but why not put
something in Documentation/Configure.help along the lines of "warning: gcc
2.96 has been known to cause errors with reiserfs!  if it goes weird on you,
_upgrade (or downgrade) your compiler and re-compile your kernel_."

imho Configure.help would be one of the best places to put notices such as
these.


-- 
/ #ozone <andrep@cse.unsw.edu.au>; (mobile# 0411 882299)
                                   trust in love to save
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
