Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269570AbRHHVvZ>; Wed, 8 Aug 2001 17:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269571AbRHHVvP>; Wed, 8 Aug 2001 17:51:15 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:36358 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S269570AbRHHVvA>;
	Wed, 8 Aug 2001 17:51:00 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: kees <kees@schoen.nl>
Date: Wed, 8 Aug 2001 23:50:55 MET-1
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: Q. what does this mean (2.4.4) 
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.40
Message-ID: <461D4A5C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8 Aug 01 at 23:12, kees wrote:

> I get tons of these in the log....
> 
> Aug  8 10:43:33 merin kernel: IPX: bound socket 0x488F.
> Aug  8 10:43:33 merin kernel: IPX: bound socket 0x4890.
> Aug  8 10:43:37 merin kernel: IPX: bound socket 0x4892.
> Aug  8 10:43:37 merin kernel: IPX: bound socket 0x4893.
> Aug  8 10:43:44 merin kernel: IPX: bound socket 0x4895.
> Aug  8 10:43:44 merin kernel: IPX: bound socket 0x4896.
> 
> These were added while running: nwuserlist.

You somehow managed to compile kernel's ipx or userspace
ncpfs with debugging. Do should not do that...
                                    Best regards,
                                        Petr Vandrovec
                                        vandrove@vc.cvut.cz
                                        
