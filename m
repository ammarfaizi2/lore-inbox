Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276538AbRJGSJL>; Sun, 7 Oct 2001 14:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276535AbRJGSJB>; Sun, 7 Oct 2001 14:09:01 -0400
Received: from mandrakesoft.mandrakesoft.com ([216.71.84.35]:11570 "EHLO
	mandrakesoft.mandrakesoft.com") by vger.kernel.org with ESMTP
	id <S276519AbRJGSIr>; Sun, 7 Oct 2001 14:08:47 -0400
Date: Sun, 7 Oct 2001 13:08:42 -0500 (CDT)
From: Jeff Garzik <jgarzik@mandrakesoft.com>
To: Martin Frey <frey@scs.ch>
cc: becker@scyld.com, tjeerd.mulder@fujitsu-siemens.com,
        torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
Subject: Re: Fix for drivers/net/natsemi.c on 64 bit platforms
In-Reply-To: <011d01c14f5a$27c8da50$6a876ace@SCHLEPPDOWN>
Message-ID: <Pine.LNX.3.96.1011007130757.26881G-100000@mandrakesoft.mandrakesoft.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, modified slightly and applied to at1700.c, natsemi.c, and
winbond-840.c.  Patches to Alan and Linus will be sent shortly...

	Jeff



