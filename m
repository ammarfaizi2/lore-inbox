Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287632AbSAHBdj>; Mon, 7 Jan 2002 20:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287868AbSAHBd3>; Mon, 7 Jan 2002 20:33:29 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:7953 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S287632AbSAHBdS>; Mon, 7 Jan 2002 20:33:18 -0500
Date: Mon, 7 Jan 2002 17:29:47 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: U133/48-bit (HDIO_DRIVE_CMD... (fwd))
Message-ID: <Pine.LNX.4.10.10201071728590.31309-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not Doable without patch infrastructure.

---------- Forwarded message ----------
Date: Wed, 19 Dec 2001 13:55:07 -0800 (PST)
From: Lucien Murray-Pitts <lucienmp@yahoo.com>
To: andre@linux-ide.org
Subject: HDIO_DRIVE_CMD...

Hi,

I'm finding it hard to get any docco on the
HDIO_DRIVE_CMD ioctl.  I want to perform a security
unlock.    Here is what I have:

args[4+512] = { SECURITY_UNLOCK, 0,0,1, 
0, PASSWORD_DATA } ;
ioctl( fd, HDIO_DRIVE_CMD, &args ) ;

Although I'm not sure this is correct?  I've started
wading through the linux ide source but as yet I can't
answer my question...

please, if you have time, drop me a line!

Lucien

__________________________________________________
Do You Yahoo!?
Check out Yahoo! Shopping and Yahoo! Auctions for all of
your unique holiday gifts! Buy at http://shopping.yahoo.com
or bid at http://auctions.yahoo.com

