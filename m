Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132226AbRDCCuP>; Mon, 2 Apr 2001 22:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132327AbRDCCuE>; Mon, 2 Apr 2001 22:50:04 -0400
Received: from epsongw2.epson.co.jp ([210.254.46.180]:14283 "EHLO
	epsongw2.epson.co.jp") by vger.kernel.org with ESMTP
	id <S132226AbRDCCtz>; Mon, 2 Apr 2001 22:49:55 -0400
Date: Tue, 3 Apr 2001 11:50:18 +0900
From: Aric Cyr <acyr@mail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:Bug when installing NVidia Driver Module
Message-ID: <20010403115018.A1886@esd.spr.epson.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Mutt/1.2.5i-jp0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried out the latest NVidia driver set, and they do work fine
for me with plain vanilla 2.4.3 on my Athlon with GCC 2.95.3.  I would
blame your compiler, it's dated July 2000, that's an old CVS version
AFAIK.

- Aric
