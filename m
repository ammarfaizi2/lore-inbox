Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291272AbSCOLgx>; Fri, 15 Mar 2002 06:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291258AbSCOLgo>; Fri, 15 Mar 2002 06:36:44 -0500
Received: from zork.zork.net ([66.92.188.166]:13839 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id <S291251AbSCOLgb>;
	Fri, 15 Mar 2002 06:36:31 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and
 2.2.21-pre3 (client)
In-Reply-To: <200203110018.BAA11921@webserver.ithnet.com>
	<15499.64058.442959.241470@charged.uio.no>
	<20020311091458.A24600@namesys.com>
	<20020311114654.2901890f.skraw@ithnet.com>
	<20020311135256.A856@namesys.com> <20020311155937.A1474@namesys.com>
	<20020315141328.A1879@namesys.com>
	<20020315123008.14237953.skraw@ithnet.com>
From: Sean Neakums <sneakums@zork.net>
X-Worst-Pick-Up-Line-Ever: "Hey baby, wanna peer with my leafnode instance?"
X-Groin-Mounted-Steering-Wheel: "Arrrr... it's driving me nuts!"
X-Message-Flag: Message text advisory: DRUGS/ALCOHOL, HEINOUS
 SELF-AGGRANDIZATION
X-Mailer: Norman
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Fri, 15 Mar 2002 11:36:30 +0000
In-Reply-To: <20020315123008.14237953.skraw@ithnet.com> (Stephan von
 Krawczynski's message of "Fri, 15 Mar 2002 12:30:08 +0100")
Message-ID: <6uofhq12rl.fsf@zork.zork.net>
User-Agent: Gnus/5.090006 (Oort Gnus v0.06) Emacs/21.1
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

commence  Stephan von Krawczynski quotation:

> Another point to clarify, my client fstab entry looks like this:
>
> 192.168.1.2:/p2/backup  /backup                 nfs     timeo=20,dev,suid,rw,exec,user,rsize=8192,wsize=8192       0 0
>
> I cannot say anything about the second fs mounted via YaST.

Surely running mount from another window/console after starting YaST would
reveal this information?

-- 
 /////////////////  |                  | The spark of a pin
<sneakums@zork.net> |  (require 'gnu)  | dropping, falling feather-like.
 \\\\\\\\\\\\\\\\\  |                  | There is too much noise.
