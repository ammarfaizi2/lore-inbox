Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130029AbRARSO2>; Thu, 18 Jan 2001 13:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130541AbRARSOS>; Thu, 18 Jan 2001 13:14:18 -0500
Received: from tisch.mail.mindspring.net ([207.69.200.157]:14362 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S130029AbRARSN7>; Thu, 18 Jan 2001 13:13:59 -0500
Date: Thu, 18 Jan 2001 12:13:56 -0600
From: Matthew Fredrickson <lists@frednet.dyndns.org>
To: Rogerio Brito <rbrito@iname.com>, linux-kernel@vger.kernel.org
Cc: pgpkeys@hislinuxbox.com
Subject: Re: VIA chipset discussion
Message-ID: <20010118121356.A28529@frednet.dyndns.org>
In-Reply-To: <Pine.LNX.4.21.0101171358020.1171-100000@ns-01.hislinuxbox.com> <20010118020408.A4713@iname.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.0.1i
In-Reply-To: <20010118020408.A4713@iname.com>; from rbrito@iname.com on Thu, Jan 18, 2001 at 02:04:08AM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 18, 2001 at 02:04:08AM -0200, Rogerio Brito wrote:
> On Jan 17 2001, David D.W. Downey wrote:
> > 
> > Could those that were involved in the VIA chipset discussion email me
> > privately at pgpkeys@hislinuxbox.com?
> 
> 	Just to add a datapoint to the discussion, I'm using a VIA
> 	chipset here (in fact, it's an Asus A7V board with a Duron), a
> 	2.2.18 kernel with André's patches and I'm only using IDE
> 	(UDMA/66 and UDMA/33 here) and I'm *not* seeing any problems.

BTW, are you having any trouble with your ps/2 mouse port in X?  On my new
ASUS board, ps/2 mouse devices (just in X, gpm works fine) act a little
crazy (random mouse movement, random clicking, etc., except I'm not the
one doing all the random movement).  I'm not sure what it is, though I do
know it's not as bad once I upgraded from 2.2.18pre21 to 2.4.0.  I think
I'm going to try using the mouse as a usb device and see if I still have
trouble.  Anyway, just wondering if you're seeing the same problem.

Matthew Fredrickson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
