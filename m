Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130818AbQKGEJD>; Mon, 6 Nov 2000 23:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130855AbQKGEIw>; Mon, 6 Nov 2000 23:08:52 -0500
Received: from vega.services.brown.edu ([128.148.19.202]:4840 "EHLO
	vega.brown.edu") by vger.kernel.org with ESMTP id <S130818AbQKGEIo>;
	Mon, 6 Nov 2000 23:08:44 -0500
Message-Id: <4.3.2.7.2.20001106230925.00ac6370@postoffice.brown.edu>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 06 Nov 2000 23:11:39 -0500
To: linux-kernel@vger.kernel.org
From: David Feuer <David_Feuer@brown.edu>
Subject: sound driver persistent state
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

People keep saying it's OK to start muted on boot, but I must say that I 
don't think this is really acceptable....  I may very well want to set my 
mixer and just leave it that way forever.... would there be any way to give 
the sound driver a scribble pad on disk to let it sa
--
This message has been brought to you by the letter alpha and the number pi.
David Feuer
David_Feuer@brown.edu

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
