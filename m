Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130966AbRAZQro>; Fri, 26 Jan 2001 11:47:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbRAZQre>; Fri, 26 Jan 2001 11:47:34 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:57907 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S130966AbRAZQrZ>; Fri, 26 Jan 2001 11:47:25 -0500
Date: Fri, 26 Jan 2001 18:47:13 +0200
From: Ville Herva <vherva@mail.niksula.cs.hut.fi>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0 quality [was: 2.4.0 uptime]
Message-ID: <20010126184713.B1002@niksula.cs.hut.fi>
In-Reply-To: <001601c0876a$db8b5a80$51a81aac@arrowhead.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <001601c0876a$db8b5a80$51a81aac@arrowhead.se>; from hes@arrowhead.se on Fri, Jan 26, 2001 at 08:37:38AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2001 at 08:37:38AM +0100, you [Hans Eric Sandström] claimed:
> BP6/Dual Cel 400 (the 2.0 load is setiathome)
> --
> [root@zekeserv /root]# uptime
>   8:28am  up 20 days, 13:04,  2 users,  load average: 2.00, 2.00, 2.00
> [root@zekeserv /root]# uname -a
> Linux zekeserv 2.4.0 #2 SMP Fri Jan 5 07:37:01 CET 2001 i686 unknown
> [root@zekeserv /root]#

Yeah. I think it can be concluded that 2.4.0 was pretty good for a .0
release. IMHO and based on my own limited experience it's much better than
2.2.0. It certainly does pretty well with that kind of ordinary CPU load,
and the bugs (if any) are related to more exotic conditions.

For most people, it appears to have worked _well_. It certainly has worked
fine for me (I had one X lock up with it, but I'd blame the nvidia drivers
for that altough they are very stable on 2.2.).

What known bugs are there btw? I think the only more serious were the
software RAID5 bug and the VIA driver issues, both of which caused fs
corruption. Some people reported problems with X (is this the same forking
problem Jeff Merkey et all tried to hunt down pre-time), and some had
trouble with booting 386 and/or other hardware. Any more? 

Hopefully Linux will squash all of them in 2.4.1!


-- v --

v@iki.fi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
