Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261685AbREOWzI>; Tue, 15 May 2001 18:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261686AbREOWy6>; Tue, 15 May 2001 18:54:58 -0400
Received: from www.topmail.de ([212.255.16.226]:37849 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S261685AbREOWyv>;
	Tue, 15 May 2001 18:54:51 -0400
From: <eccesys@topmail.de>
To: <linux-kernel@vger.kernel.org>
Subject: Re: this LANA thing
Message-Id: <20010515225209.45A21A5AA2F@www.topmail.de>
Date: Wed, 16 May 2001 00:52:09 +0200 (MET DST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This way you can detect new disks, adapter cards, serial ports, etc. any
> time after the system is up.  All disks are identified as "/dev/hdiskX",

I bet it will go in as /dev/hdiscX ;-)

(I prefer disk)

But I wish you to not vanish the scheme in which one can also address a
given device by its location. Confer devfs: /dev/discs/disc0 to /dev/ide/bus...
Because I really sometimes wish to address my harddisks, and not some logical crap.

-mirabilos
-- 
by telnet
