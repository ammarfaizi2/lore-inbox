Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130026AbRA3TWB>; Tue, 30 Jan 2001 14:22:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131306AbRA3TVm>; Tue, 30 Jan 2001 14:21:42 -0500
Received: from austin.jhcloos.com ([206.224.83.202]:45584 "HELO
	austin.jhcloos.com") by vger.kernel.org with SMTP
	id <S129912AbRA3TV2>; Tue, 30 Jan 2001 14:21:28 -0500
To: "Kevin Krieser" <kkrieser_list@footballmail.com>
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: Recommended swap for 2.4.x.
In-Reply-To: <004b01c08a53$0e5da270$0700a8c0@thinkpad>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <004b01c08a53$0e5da270$0700a8c0@thinkpad> ("Kevin Krieser"'s message of "Mon, 29 Jan 2001 18:24:49 -0600")
Date: 30 Jan 2001 13:21:27 -0600
Message-ID: <m3itmwlubs.fsf@austin.jhcloos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Kevin" == Kevin Krieser <kkrieser_list@footballmail.com> writes:

Kevin> You mean my current 1.9 gig of swap is overkill? :) I have
Kevin> 256MB of RAM, and am currently not using any of the swap.

Looks like you are a perfect candidate for testing shmfs[1] as /tmp, eh?

[1] or vmfs or tmpfs or whatever it ends up being called when it get's
    into the mainline kernel....

-JimC
-- 
James H. Cloos, Jr.  <http://jhcloos.com/public_key>     1024D/ED7DAEA6 
<cloos@jhcloos.com>  E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
