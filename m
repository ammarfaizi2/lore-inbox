Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: (majordomo@vger.rutgers.edu) by vger.rutgers.edu via listexpand id <S157241AbQGWWP5>; Sun, 23 Jul 2000 18:15:57 -0400
Received: by vger.rutgers.edu id <S157527AbQGWWO7>; Sun, 23 Jul 2000 18:14:59 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2643 "EHLO atrey.karlin.mff.cuni.cz") by vger.rutgers.edu with ESMTP id <S157504AbQGWWOg>; Sun, 23 Jul 2000 18:14:36 -0400
Message-ID: <20000723202220.B118@bug.ucw.cz>
Date: Sun, 23 Jul 2000 20:22:20 +0200
From: Pavel Machek <pavel@suse.cz>
To: Scott A Crosby <crosby@qwes.math.cmu.edu>, linux-kernel@vger.rutgers.edu, video4linux@redhat.com, linuxperf@nl.linux.org
Cc: Jean-Michel Smith <jean-michel@kcco2.com>, Doug Schafer <doug@schafers.com>
Subject: Re: Mini-howto: High performance large Ext2fs filesystems  [[BETA]]
References: <20000710043112.B296@fuchs.offl.uni-jena.de> <Pine.LNX.4.10.10007170013580.28180-100000@qwe4.math.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.10.10007170013580.28180-100000@qwe4.math.cmu.edu>; from Scott A Crosby on Mon, Jul 17, 2000 at 12:45:22AM -0400
Sender: owner-linux-kernel@vger.rutgers.edu

Hi!

> Summary: How to save 2% more space, and do a full fsck on 70 gb of
> diskspace. (3 drives) in 6 minutes. And other tricks and tips for making
> ext2fs much more pleasant on large filesystems... Forward where you think
> they want to know.
> 
> It started as a slashdot post 6 months ago, but I've done nothing since,
> so I'm sending it out as-is.. You have been warned..

You might want to take a look at
http://www.suse.cz/development/fastfsck.html...
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
