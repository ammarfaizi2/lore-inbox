Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136106AbRAJSRh>; Wed, 10 Jan 2001 13:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136121AbRAJSR2>; Wed, 10 Jan 2001 13:17:28 -0500
Received: from msgbas1tx.cos.agilent.com ([192.6.9.34]:50914 "HELO
	msgbas1t.cos.agilent.com") by vger.kernel.org with SMTP
	id <S136106AbRAJSRK>; Wed, 10 Jan 2001 13:17:10 -0500
Message-ID: <FEEBE78C8360D411ACFD00D0B747797188093A@xsj02.sjs.agilent.com>
From: hiren_mehta@agilent.com
To: linux-kernel@vger.kernel.org
Subject: RE: 2.4.0 release and ia64
Date: Wed, 10 Jan 2001 11:17:07 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like, those patches are for the test kernels. 
I could not find one that can be used for the final released 2.4.0 kernel. 
I am not sure which one should I use. So far I was using test10 
kernel and then corresponding ia64 patch for test10 on my ia64 system.
Is it that I can apply any patch to the released 2.4.0 kernel ?
If not , then which patch should I use ?

Thanks and regards,
-hiren

> -----Original Message-----
> From: Bill Nottingham [mailto:notting@redhat.com]
> Sent: Wednesday, January 10, 2001 10:09 AM
> To: linux-kernel@vger.kernel.org
> Subject: Re: 2.4.0 release and ia64
> 
> 
> hiren_mehta@agilent.com (hiren_mehta@agilent.com) said: 
> > Now that 2.4.0 kernel is officially released, does it run
> > or ia64 as it is or do we need to apply any patches to make
> > it run on ia64 ?
> 
> There's a patch for it in ports/ia64 on your favorite linux kernel
> mirror.
> 
> Bill
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
