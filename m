Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbVI1SD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbVI1SD5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 14:03:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750708AbVI1SD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 14:03:57 -0400
Received: from xenotime.net ([66.160.160.81]:11457 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1750705AbVI1SD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 14:03:56 -0400
Date: Wed, 28 Sep 2005 11:03:52 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Paul Jackson <pj@sgi.com>
cc: Linus Torvalds <torvalds@osdl.org>, kurosawa@valinux.co.jp,
       taka@valinux.co.jp, magnus.damm@gmail.com, dino@in.ibm.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net,
       akpm@osdl.org
Subject: Re: [PATCH] cpuset read past eof memory leak fix
In-Reply-To: <20050928105316.0684c7cf.pj@sgi.com>
Message-ID: <Pine.LNX.4.58.0509281102330.14803@shark.he.net>
References: <20050908225539.0bc1acf6.pj@sgi.com> <20050909.203849.33293224.taka@valinux.co.jp>
 <20050909063131.64dc8155.pj@sgi.com> <20050910.161145.74742186.taka@valinux.co.jp>
 <20050910015209.4f581b8a.pj@sgi.com> <20050926093432.9975870043@sv1.valinux.co.jp>
 <20050927013751.47cbac8b.pj@sgi.com> <20050927113902.C78A570046@sv1.valinux.co.jp>
 <20050928092558.61F6170041@sv1.valinux.co.jp> <20050928064224.49170ca7.pj@sgi.com>
 <Pine.LNX.4.58.0509280758560.3308@g5.osdl.org> <20050928105316.0684c7cf.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2005, Paul Jackson wrote:

> Linus wrote:
> > please for the future keep authorship intact by having
> > a "From: ...
>
> You guessed right.  Your non-technical note was applicable.
>
> Andrew - why doesn't your "The perfect patch" mention this?
>     http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
>
> Linus - would you like a patch to Documentation/SubmittingPatches
>     that mentions this?
>
> Hmmm ... I don't even see the "Acked-by" in these patch guides either.
> Probably I should include that in SubmittingPatches as well.
>
> Too bad that first line doesn't start "Author:" instead of "From:".
> Oh well - I see Andrew already suggested that, and you declined.
> (You should'a listened to him ;).

Paul, did you see Linus's email on the canonical patch format?
(I can understand if you missed it. :)

http://www.ussg.iu.edu/hypermail/linux/kernel/0504.0/1865.html

-- 
~Randy
