Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267797AbRGUUEA>; Sat, 21 Jul 2001 16:04:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267798AbRGUUDu>; Sat, 21 Jul 2001 16:03:50 -0400
Received: from jdi.jdimedia.nl ([212.204.192.51]:57298 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S267797AbRGUUDd>;
	Sat, 21 Jul 2001 16:03:33 -0400
Date: Sat, 21 Jul 2001 22:03:15 +0200 (CEST)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
X-X-Sender: <igmar@jdi.jdimedia.nl>
To: <linux-kernel@vger.kernel.org>
cc: <hermes@gibson.dropbear.id.au>
Subject: Dynalink L11C multicast
Message-ID: <Pine.LNX.4.33.0107212155450.29008-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Hi,

Plugging in my Dynalink L11C (Prism2 card with manfid 0x0156, 0x0002)
gives me :

eth1: Error -110 setting multicast list
eth1: Error -16 setting multicast list
eth1: Error -16 setting multicast list

According to the comment on line 3128 of orinoco.c, this is untested.
David might want to look at this..


	Igmar

-- 

Igmar Palsenberg
JDI Media Solutions

Boulevard Heuvelink 102
6828 KT Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

