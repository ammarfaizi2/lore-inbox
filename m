Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273305AbRJTOFS>; Sat, 20 Oct 2001 10:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273333AbRJTOFI>; Sat, 20 Oct 2001 10:05:08 -0400
Received: from verdi.kjist.ac.kr ([203.237.41.93]:2181 "EHLO verdi.kjist.ac.kr")
	by vger.kernel.org with ESMTP id <S273305AbRJTOEz>;
	Sat, 20 Oct 2001 10:04:55 -0400
Date: Sat, 20 Oct 2001 23:04:57 +0900
Message-Id: <200110201404.f9KE4vG18587@verdi.kjist.ac.kr>
From: "G. Hugh Song" <hugh@verdi.kjist.ac.kr>
To: linux-kernel@vger.kernel.org
Subject: Compile failure with the -aa* series
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Andrea,

I do not understand why you added line 251 of drivers/net/Config.in.
That has given me a trouble since some time around 2.4.10aa*.

Of course, I always got rid of that line to compile the kernel.

Regards,

G. Hugh Song
