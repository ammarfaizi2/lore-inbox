Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131179AbRAIAhv>; Mon, 8 Jan 2001 19:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130676AbRAIAhk>; Mon, 8 Jan 2001 19:37:40 -0500
Received: from mnh-1-29.mv.com ([207.22.10.61]:7946 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S130070AbRAIAh2>;
	Mon, 8 Jan 2001 19:37:28 -0500
Message-Id: <200101090147.UAA05211@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Geoff Hoff <ghoff@math.utk.edu>
cc: Chris Mason <mason@suse.com>, user-mode-linux-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] Re: [reiserfs-list] BUG at inode.c:371 
In-Reply-To: Your message of "Mon, 08 Jan 2001 18:12:38 EST."
             <20010108231238.3795.qmail@utkmath3.math.utk.edu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 08 Jan 2001 20:47:11 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You've got two problems here, and one of them is mine:

> In uml I continue the debian installation off of cdrom and as I say ok
> to the final screen I get a "Kernel panic: Kernel mode fault at addr
> 0xbefffe90, ip 0x1009f315" from user-mode linux which is running as
> me, not as root.

Can you get me a stack trace from the panic?  See http://user-mode-linux.source
forge.net/trouble.html if you need information on doing that.

				Jeff


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
