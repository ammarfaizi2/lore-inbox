Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130794AbRAOG4p>; Mon, 15 Jan 2001 01:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131050AbRAOG4f>; Mon, 15 Jan 2001 01:56:35 -0500
Received: from linuxcare.com.au ([203.29.91.49]:54022 "EHLO
	front.linuxcare.com.au") by vger.kernel.org with ESMTP
	id <S130794AbRAOG42>; Mon, 15 Jan 2001 01:56:28 -0500
From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14946.40741.210270.905298@diego.linuxcare.com.au>
Date: Mon, 15 Jan 2001 17:56:37 +1100 (EST)
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
CC: Mike Galbraith <mikeg@wen-online.de>, Alvaro Lopes <alvieboy@alvie.com>
Subject: Re: [PATCH] fix for ppp_async lockup in 2.4.0
In-Reply-To: <14946.40642.426432.698066@diego.linuxcare.com.au>
In-Reply-To: <14946.40642.426432.698066@diego.linuxcare.com.au>
X-Mailer: VM 6.75 under Emacs 20.4.1
Reply-To: paulus@linuxcare.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I meant to add that I have tested the patch I sent on both UP and SMP;
PPP connections work fine and the exploit program doesn't hang the
system.

Paul.

-- 
Paul Mackerras, Open Source Research Fellow, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
