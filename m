Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130396AbRBBWmv>; Fri, 2 Feb 2001 17:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130404AbRBBWml>; Fri, 2 Feb 2001 17:42:41 -0500
Received: from cs.columbia.edu ([128.59.16.20]:39897 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S130396AbRBBWmf>;
	Fri, 2 Feb 2001 17:42:35 -0500
Date: Fri, 2 Feb 2001 14:42:29 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Hans Reiser <reiser@namesys.com>, <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, Jan Kasprzak <kas@informatics.muni.cz>
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink
 related)
In-Reply-To: <E14OoD8-0007GI-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0102021438320.9097-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Feb 2001, Alan Cox wrote:

> Oh I can see why Hans wants to cut down his bug reporting load. I can also
> say from experience it wont work. If you put #error in then everyone will
> mail him and complain it doesnt build, if you put #warning in nobody will
> read it and if you dont put anything in you get the odd bug report anyway.
>
> Basically you can't win and unfortunately a shrink wrap forcing the user
> to read the README file for the kernel violates the GPL ..

Oh, don't get me wrong, I fully understand that it's a lose-lose
situation. All I'm saying is that it was an incredibly bad idea to have
two compilers, one broken and one ok, identify themselves as the same
version.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
