Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130877AbRAQR53>; Wed, 17 Jan 2001 12:57:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131455AbRAQR5T>; Wed, 17 Jan 2001 12:57:19 -0500
Received: from msgbas1tx.cos.agilent.com ([192.6.9.34]:46273 "HELO
	msgbas1t.cos.agilent.com") by vger.kernel.org with SMTP
	id <S130877AbRAQR5E>; Wed, 17 Jan 2001 12:57:04 -0500
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880945@xsj02.sjs.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: linux-kernel@vger.kernel.org
Subject: RE: Problems in 2.4 kernel 
Date: Wed, 17 Jan 2001 12:49:58 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think when you configure the kernel (make menuconfig) you did not 
make floppy driver part of the kernel. I also faced the same problem,
and I fixed it by making the floppy driver part of the kernel.

Let me know if this helps.

-hiren

> -----Original Message-----
> From: Sajeev [mailto:sajeevm@vantel.net]
> Sent: Wednesday, January 17, 2001 1:12 AM
> To: linux-kernel@vger.kernel.org
> Subject: Problems in 2.4 kernel 
> 
> 
> Hi.
> I am not able to mount my floppy drive. When I try to mount 
> it gives me the
> following error
> 'mount: /dev/fd0 has wrong major or minor number'
> I am running the latest kernel release i.e. 2.4 .
> I tried recreating the node but it has been of no use.
> Can anyone please help me.
> Thanks
> Sajeev
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
