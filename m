Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129763AbQLSUFD>; Tue, 19 Dec 2000 15:05:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129744AbQLSUEw>; Tue, 19 Dec 2000 15:04:52 -0500
Received: from [213.8.185.127] ([213.8.185.127]:58898 "EHLO callisto.yi.org")
	by vger.kernel.org with ESMTP id <S129742AbQLSUEr>;
	Tue, 19 Dec 2000 15:04:47 -0500
Date: Tue, 19 Dec 2000 21:31:42 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: success with test13-pre3
Message-ID: <Pine.LNX.4.21.0012192126290.21582-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm glad to report that 2.4.0-test13-pre3 fixes the lockup (and
odd Oops messages) problems I had from test12 til test13-pre2. I've been
running it on both of my computers for a day and a half and everything is
OK.

At first, we thought it had something to do with the modules I was
using, but I was unable to confirm that, so I suspected it was something
to do with the kernel itself, I'm glad it was fixed.

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
