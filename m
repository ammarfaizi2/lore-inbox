Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLWNDP>; Sat, 23 Dec 2000 08:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129228AbQLWNDG>; Sat, 23 Dec 2000 08:03:06 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:41479 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S129183AbQLWNC7>;
	Sat, 23 Dec 2000 08:02:59 -0500
Date: Sat, 23 Dec 2000 18:02:12 +0530 (IST)
From: Sourav Sen <sourav@csa.iisc.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: whats happening
In-Reply-To: <XFMail.20001223062319.markorr@intersurf.com>
Message-ID: <Pine.SOL.3.96.1001223180009.12949B-100000@kohinoor.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In some parts of the kernel code I find expression like 

len = (len + ~PAGE_MASK) & PAGE_MASK ;

Whats happening to len?

~sourav

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
