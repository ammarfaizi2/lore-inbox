Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129436AbRAJVzM>; Wed, 10 Jan 2001 16:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129401AbRAJVzC>; Wed, 10 Jan 2001 16:55:02 -0500
Received: from clueserver.org ([206.163.47.224]:53521 "HELO clueserver.org")
	by vger.kernel.org with SMTP id <S129436AbRAJVyq>;
	Wed, 10 Jan 2001 16:54:46 -0500
Date: Wed, 10 Jan 2001 14:04:41 -0800 (PST)
From: Alan Olsen <alan@clueserver.org>
To: linux-kernel@vger.kernel.org
Subject: X performance on 2.4.0 v.s. 2.4.0-test12
In-Reply-To: <Pine.LNX.4.30.0101102119550.7069-100000@atlantis.tgcnet.dk>
Message-ID: <Pine.LNX.4.10.10101101358440.17692-100000@clueserver.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have seen a number of reports claiming something broken in 2.4.0 for
DRI.

I have tested under 2.4.0 and 2.4.0 test 12 with the exact same setup.

I see a slight variation in frame rates under the release version, but so
small as to be within statistical varience.

Everything else seems to work in reguards to DRI and AGPGART so far.  (Of
course, the X server on my desk will now explode since I said that...)

I have noticed that the framerate takes a hard nosedive if xinerama is
turned on, but that is explained in the docs.

I have not seen any "flashing" behaviour or any other reported
weirdnesses.

Maybe it is the sacrifices made to dark penguin gods during that last full
moon. 

alan@ctrl-alt-del.com | Note to AOL users: for a quick shortcut to reply
Alan Olsen            | to my mail, just hit the ctrl, alt and del keys.
    "In the future, everything will have its 15 minutes of blame."

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
