Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129759AbQLXNgC>; Sun, 24 Dec 2000 08:36:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129867AbQLXNfw>; Sun, 24 Dec 2000 08:35:52 -0500
Received: from maynard.mail.mindspring.net ([207.69.200.243]:43031 "EHLO
	maynard.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S129759AbQLXNfm>; Sun, 24 Dec 2000 08:35:42 -0500
Date: Sun, 24 Dec 2000 06:05:12 -0700
From: Jeff Lightfoot <jeffml@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: innd mmap bug in 2.4.0-test12
Message-ID: <20001224060512.A11066@www.thefoots.com>
Reply-To: Jeff Lightfoot <jeffml@pobox.com>
In-Reply-To: <20001224092835.B649@wonderland.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001224092835.B649@wonderland.linux.it>; from md@Linux.IT on Sun, Dec 24, 2000 at 01:54:50AM -0700
X-Operating-System: Linux/2.4.0-test13-pre4 (i686)
X-URL: http://thefoots.com
X-Uptime: 5:56am  up 10:02,  3 users,  load average: 1.02, 1.02, 1.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Marco d'Itri" (md@Linux.IT) wrote:
> I can confirm the bug which loses updates to the inn active file when
> it's unmapped is present again in 2.4.0-test12.

It is also still in 2.4.0-test13-pre4 in case someone thought they had
fixed it.

-- 
Jeff Lightfoot   --    jeffml at pobox.com   --   http://thefoots.com/
    "I see the light at the end of the tunnel now ... someone please
    tell me it's not a train" -- Cracker
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
