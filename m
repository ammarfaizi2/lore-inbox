Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130391AbQLNBlt>; Wed, 13 Dec 2000 20:41:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129860AbQLNBlk>; Wed, 13 Dec 2000 20:41:40 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32014 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129810AbQLNBlW>; Wed, 13 Dec 2000 20:41:22 -0500
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
To: sabre@nondot.org (Chris Lattner)
Date: Thu, 14 Dec 2000 01:11:42 +0000 (GMT)
Cc: lk@tantalophile.demon.co.uk (Jamie Lokier),
        viro@math.psu.edu (Alexander Viro),
        mhaque@haque.net (Mohammad A. Haque), ben@kalifornia.com (Ben Ford),
        linux-kernel@vger.kernel.org, orbit-list@gnome.org,
        korbit-cvs@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.21.0012131755030.24165-100000@www.nondot.org> from "Chris Lattner" at Dec 13, 2000 06:21:31 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146Mvx-0003Zj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Don't worry about kORBit.  Like most open source projects, it will simply
> die out after a while, because people don't find it interesting and there
> is really no place for it.  If it becomes useful, mature, and refined,
> however, it could be a very powerful tool for a large class of problems
> (like moving code OUT of the kernel).

I do have one sensible question. Given that corba is while flexible a 
relatively expensive encoding system, wouldn't it be better to keep corba
out of kernel space and talk something which is a simple and cleaner encoding

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
