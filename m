Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265902AbRGOFrq>; Sun, 15 Jul 2001 01:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265641AbRGOFrh>; Sun, 15 Jul 2001 01:47:37 -0400
Received: from wdskppp19.mpls.uswest.net ([63.226.148.19]:62557 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S265887AbRGOFr2>; Sun, 15 Jul 2001 01:47:28 -0400
Date: Sun, 15 Jul 2001 00:37:36 -0500 (CDT)
From: Nitebirdz <nitebirdz@qwest.net>
X-X-Sender: <nitebirdz@localhost.localdomain>
To: "Tim R. Young" <try@lyang.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: /boot/kernel.h in redhat
In-Reply-To: <20010714163901.B24263@box.lyang.net>
Message-ID: <Pine.LNX.4.33.0107150034590.21124-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jul 2001, Tim R. Young wrote:

> Date: Sat, 14 Jul 2001 16:39:01 -0700
> From: Tim R. Young <try@lyang.net>
> To: linux-kernel@vger.kernel.org
> Subject: /boot/kernel.h in redhat
>
> Hi,
>
> On redhat system, /etc/rc.d/rc.sysinit creates
> /boot/kernel.h each time machine boots.
> I am wondering what is the use of /boot/kernel.h?
>
> Thanks
>


This may provide you with an answer (do a search for the string "kernel.h"
in the page):

http://lwn.net/2001/0517/a/kernel-2.4.spec.php3


It's added by the Red Hat developers to the kernel spec file that they
install from RPM.


-- 
------------------------------------------------------
Nitebirdz
------------------------------------------------------
http://www.linuxnovice.org
News, tips, articles, links...

*** http://www.mozilla.org ***

