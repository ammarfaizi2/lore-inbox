Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132155AbRBEMUn>; Mon, 5 Feb 2001 07:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131941AbRBEMUY>; Mon, 5 Feb 2001 07:20:24 -0500
Received: from mail.isis.co.za ([196.15.218.226]:16134 "EHLO mail.isis.co.za")
	by vger.kernel.org with ESMTP id <S129116AbRBEMUF>;
	Mon, 5 Feb 2001 07:20:05 -0500
Message-Id: <4.3.2.7.0.20010205133359.00aac3f0@192.168.0.18>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 05 Feb 2001 14:19:54 +0200
To: linux-kernel@vger.kernel.org
From: Pat Verner <pat@isis.co.za>
Subject: Linux 2.4.[01] and BogoMips
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have Linux running on several older Pentium machines - Pentium -166 MHz 
and Pentium - 120 Mhz.

Under kernel 2.2.13+ these machines report a BogoMips of 66 or 47 
respectively;  suddenly under kernel 2.4.[01] the speed is suddenly 
reported as 332 and 238 respectively.

Has there been a change in the definition of "BogoMips"?

Regards
=Pat
--
Pat Verner				E-Mail:  pat@isis.co.za
           Isis Information Systems (Pty) Ltd
           PO Box 281, Irene, 0062, South Africa
Phone: +27-12-667-1411	      	Fax: +27-12-667-3800

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
