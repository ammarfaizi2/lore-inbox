Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbQLHTBP>; Fri, 8 Dec 2000 14:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130146AbQLHTBF>; Fri, 8 Dec 2000 14:01:05 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:263 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP
	id <S129669AbQLHTA5>; Fri, 8 Dec 2000 14:00:57 -0500
Date: Fri, 8 Dec 2000 19:30:28 +0100 (CET)
From: Martin Kacer <M.Kacer@sh.cvut.cz>
To: Andrea Arcangeli <andrea@suse.de>
cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.2.18pre25
In-Reply-To: <20001208190829.A17848@inspiron.random>
Message-ID: <Pine.LNX.4.30.0012081918130.7566-100000@duck.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2000, Andrea Arcangeli wrote:

# On Fri, Dec 08, 2000 at 06:02:57PM +0100, Martin Kacer wrote:
# >    Is there any chance to get rid of these VMM failures?
# You should apply this patch on top of 2.2.18pre25:
# ftp://.../VM-global-2.2.18pre25-7.bz2

   Well, I've found that VM-global patch before, of course. Until now, the
last version was against pre18. Since I do not know the exact rules for
including new things into Alan's tree, I thought that VM-global patch was
already included in pre24. Sorry for my lack of experience. ;-)) I should
have checked it.
   As I wrote before, I had no time recently to follow the mailing list
carefully and I didn't know exactly what VM-global patch is.

# >    It seems we need to return back to 2.2.13 for some time. :-(
# Definitely no, you only need to apply the above collection of bugfixes.

   Ok, I can try it, at least.
   I will let you know about results.

   Martin.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
