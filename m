Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131775AbRAHADM>; Sun, 7 Jan 2001 19:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132581AbRAHADC>; Sun, 7 Jan 2001 19:03:02 -0500
Received: from 209.102.21.2 ([209.102.21.2]:12557 "EHLO dragnet.seagull.net")
	by vger.kernel.org with ESMTP id <S131775AbRAHACq>;
	Sun, 7 Jan 2001 19:02:46 -0500
Message-ID: <3A58D32D.D52C1BB2@goingware.com>
Date: Sun, 07 Jan 2001 20:35:57 +0000
From: "Michael D. Crawford" <crawford@goingware.com>
Organization: GoingWare Inc. - Expert Software Development and Consulting
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.4.0-ac2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] typo in vesafb.c (against 2.4.0-ac3)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stewart@neuron.com said:
> 
> this looks like a typo and fixes a compile error in 
> 2.4.0-ac3. 

(replacing temp_sze with temp_size in drivers/video/vesafb.c)

I had this problem too.

For some reason this patch kept getting rejected by the patch program when I
tried to apply it, but editing the file by hand to do what the patch does fixed
the problem.

Mike
-- 
Michael D. Crawford
GoingWare Inc. - Expert Software Development and Consulting
http://www.goingware.com/
crawford@goingware.com

   Tilting at Windmills for a Better Tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
