Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbVI1RyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbVI1RyK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 13:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVI1RyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 13:54:10 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:48873 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750829AbVI1RyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 13:54:09 -0400
Date: Wed, 28 Sep 2005 10:53:16 -0700
From: Paul Jackson <pj@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: kurosawa@valinux.co.jp, taka@valinux.co.jp, magnus.damm@gmail.com,
       dino@in.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, akpm@osdl.org
Subject: Re: [PATCH] cpuset read past eof memory leak fix
Message-Id: <20050928105316.0684c7cf.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.58.0509280758560.3308@g5.osdl.org>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.9975870043@sv1.valinux.co.jp>
	<20050927013751.47cbac8b.pj@sgi.com>
	<20050927113902.C78A570046@sv1.valinux.co.jp>
	<20050928092558.61F6170041@sv1.valinux.co.jp>
	<20050928064224.49170ca7.pj@sgi.com>
	<Pine.LNX.4.58.0509280758560.3308@g5.osdl.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus wrote:
> please for the future keep authorship intact by having 
> a "From: ...

You guessed right.  Your non-technical note was applicable.

Andrew - why doesn't your "The perfect patch" mention this?
    http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt

Linus - would you like a patch to Documentation/SubmittingPatches
    that mentions this?

Hmmm ... I don't even see the "Acked-by" in these patch guides either.
Probably I should include that in SubmittingPatches as well.

Too bad that first line doesn't start "Author:" instead of "From:".
Oh well - I see Andrew already suggested that, and you declined.
(You should'a listened to him ;).

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
