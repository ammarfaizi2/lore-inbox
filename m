Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132477AbRANMPe>; Sun, 14 Jan 2001 07:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132479AbRANMPY>; Sun, 14 Jan 2001 07:15:24 -0500
Received: from jdi.jdimedia.nl ([212.204.192.51]:27665 "EHLO jdi.jdimedia.nl")
	by vger.kernel.org with ESMTP id <S132477AbRANMPK>;
	Sun, 14 Jan 2001 07:15:10 -0500
Date: Sun, 14 Jan 2001 13:15:02 +0100 (CET)
From: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
To: "David S. Miller" <davem@redhat.com>
cc: Andi Kleen <ak@suse.de>, Igmar Palsenberg <i.palsenberg@jdimedia.nl>,
        Harald Welte <laforge@gnumonks.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0 + iproute2
In-Reply-To: <14945.38406.478723.657639@pizda.ninka.net>
Message-ID: <Pine.LNX.4.30.0101141313470.16758-100000@jdi.jdimedia.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> People must be really suffering right now, and we ought to get
> /proc/errno_strings implemented as soon as possible... :-)

First the help describing large tables should be changed. It's wrong.
String errors don't belong in kernel space IMHO.

	Igmar


-- 

--
Igmar Palsenberg
JDI Media Solutions

Jansplaats 11
6811 GB Arnhem
The Netherlands

mailto: i.palsenberg@jdimedia.nl
PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
