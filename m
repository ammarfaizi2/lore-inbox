Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288058AbSACAJ5>; Wed, 2 Jan 2002 19:09:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287976AbSACAIS>; Wed, 2 Jan 2002 19:08:18 -0500
Received: from pizda.ninka.net ([216.101.162.242]:7296 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S288033AbSACAHu>;
	Wed, 2 Jan 2002 19:07:50 -0500
Date: Wed, 02 Jan 2002 16:06:41 -0800 (PST)
Message-Id: <20020102.160641.92584044.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: garzik@havoc.gtf.org, manfred@colorfullife.com, klink@clouddancer.com,
        linux-kernel@vger.kernel.org
Subject: Re: 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E16Izg0-0008Bm-00@the-village.bc.nu>
In-Reply-To: <20011225141441.A14941@havoc.gtf.org>
	<E16Izg0-0008Bm-00@the-village.bc.nu>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Tue, 25 Dec 2001 22:03:59 +0000 (GMT)
   
   > required DaveM made it unconditional...  I think the checkin comment was
   > something along the lines of "make it unconditional unless Alan
   > complains about kernel bloat" :)
   
   And I did complain. "Red Hat needs XYZ so we make it mandatory" is not an
   appropriate approach to a problem.

[ Just got back from British Columbia... ]

No you did not complain.  I asked you specifically if it was ok, and
your response was that turning netlink/rtnetlink on by default was
fine with you.

It has zilch to do with redhat anything, in fact I had to ask vendors
first if they could still fit the kernel on their boot disks if I
added ~5K of object code to kernels with networking enabled.

It has everything to do with iproute2 and tcp_diag using it.

Franks a lot,
David S. Miller
davem@redhat.com
