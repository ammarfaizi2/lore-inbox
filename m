Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129868AbQLNIeB>; Thu, 14 Dec 2000 03:34:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129950AbQLNIdk>; Thu, 14 Dec 2000 03:33:40 -0500
Received: from anakin.xinit.se ([194.14.168.3]:13063 "HELO anakin.xinit.se")
	by vger.kernel.org with SMTP id <S129868AbQLNIdb>;
	Thu, 14 Dec 2000 03:33:31 -0500
Message-ID: <3A387F06.3F82F188@arrowhead.se>
Date: Thu, 14 Dec 2000 09:04:22 +0100
From: josef höök <josef.hook@arrowhead.se>
Organization: Arrowhead
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <E146Mvx-0003Zj-00@the-village.bc.nu> <Pine.GSO.4.21.0012132037110.6300-100000@weyl.math.psu.edu> <20001213202348.J864@valinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chip Salzenberg wrote:

> According to Alexander Viro:
> > 9P is quite simple and unlike CORBA it had been designed for taking
> > kernel stuff to userland.  Besides, authors definitely understand
> > UNIX...
>
> As nice as 9P is, it'll need some tweaks to work with Linux.
> For example, it limits filenames to 30 characters; that's not OK.
> --
> Chip Salzenberg            - a.k.a. -            <chip@valinux.com>
>    "Give me immortality, or give me death!"  // Firesign Theatre
>

Another thing in mind that if we would want to use 9P we would also need to
port IL .

/joh

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
