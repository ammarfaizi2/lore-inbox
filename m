Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271730AbRIGLSW>; Fri, 7 Sep 2001 07:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271723AbRIGLSM>; Fri, 7 Sep 2001 07:18:12 -0400
Received: from ftpbox.mot.com ([129.188.136.101]:55969 "EHLO ftpbox.mot.com")
	by vger.kernel.org with ESMTP id <S271721AbRIGLR5>;
	Fri, 7 Sep 2001 07:17:57 -0400
Date: Fri, 7 Sep 2001 16:51:48 +0530 (IST)
From: "Ch.S.P.Nanda" <csaradap@mihy.mot.com>
To: <linux-kernel@vger.kernel.org>
Subject: error in serial device 
Message-ID: <Pine.LNX.4.33.0109071650440.2494-100000@TRPC2.mihy.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I am trying to run a slip server on the linux 2.4. When i say
 slattach -p slip /dev/ttyS0 &

I get a message like
---INIT: Id "T1" respawning too fast: disabled for 5 minutes---
 Why it is so though i have not defined any speed to serial device with -s
 option

Is it is due to because  kernel is  corrupt or some prob like that..

Please help
ch.s.p.nanda


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

