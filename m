Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130110AbRBBW5w>; Fri, 2 Feb 2001 17:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130425AbRBBW5m>; Fri, 2 Feb 2001 17:57:42 -0500
Received: from cs.columbia.edu ([128.59.16.20]:27615 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S130110AbRBBW5a>;
	Fri, 2 Feb 2001 17:57:30 -0500
Date: Fri, 2 Feb 2001 14:57:25 -0800 (PST)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Hans Reiser <reiser@namesys.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, Jan Kasprzak <kas@informatics.muni.cz>
Subject: Re: [reiserfs-list] ReiserFS Oops (2.4.1, deterministic, symlink 
 related)
In-Reply-To: <3A7B2F7C.52AA6AFA@namesys.com>
Message-ID: <Pine.LNX.4.30.0102021454320.9097-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Feb 2001, Hans Reiser wrote:

> That said, my opinion is that bug reporting load is not as important as bug
> avoidance, but I understand your position has merit to it also.

If you do it, at least restrict it to 2.96.0. Maybe Red Hat will see the
light and release a fixed 2.96.1...

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
