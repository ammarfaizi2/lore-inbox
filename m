Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279756AbRJYL0Q>; Thu, 25 Oct 2001 07:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279757AbRJYL0G>; Thu, 25 Oct 2001 07:26:06 -0400
Received: from arabuusi.tky.hut.fi ([130.233.24.169]:30354 "HELO
	arabuusi.tky.hut.fi") by vger.kernel.org with SMTP
	id <S279756AbRJYLZ4>; Thu, 25 Oct 2001 07:25:56 -0400
To: linux-kernel@vger.kernel.org
Subject: HPT366 and 80G Maxtor Diamondmaxes
Message-ID: <1004009868.3bd7f98c86e95@mail.arabuusimiehet.com>
Date: Thu, 25 Oct 2001 14:37:48 +0300 (EEST)
From: Janne Liimatainen <jannel@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

the HPT 1.25 bios seems to be buggy and detects the 80 gig maxtors as 13 gigs. 
Kernel 2.4.9 reports the highpoint controller as dma disabled by bios and the 
drives get max. 2 megabytes/s speeds. Is there a way to get dma on? hdparm -d1 
just reports operation not permitted.

Please CC me!

Thanks!

--
  -Janne
