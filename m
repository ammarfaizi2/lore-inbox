Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131644AbRDCM0u>; Tue, 3 Apr 2001 08:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131654AbRDCM0b>; Tue, 3 Apr 2001 08:26:31 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:19461 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131644AbRDCM0U>; Tue, 3 Apr 2001 08:26:20 -0400
Subject: Re: PROBLEM:Bug when installing NVidia Driver Module
To: acyr@mail.com (Aric Cyr)
Date: Tue, 3 Apr 2001 13:28:06 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010403115018.A1886@esd.spr.epson.co.jp> from "Aric Cyr" at Apr 03, 2001 11:50:18 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kPur-0007xT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have tried out the latest NVidia driver set, and they do work fine
> for me with plain vanilla 2.4.3 on my Athlon with GCC 2.95.3.  I would
> blame your compiler, it's dated July 2000, that's an old CVS version
> AFAIK.

The memcpy one is their bug.
