Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265315AbRF0RKC>; Wed, 27 Jun 2001 13:10:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265334AbRF0RJw>; Wed, 27 Jun 2001 13:09:52 -0400
Received: from msgbas1tx.cos.agilent.com ([192.6.9.34]:44515 "HELO
	msgbas1t.cos.agilent.com") by vger.kernel.org with SMTP
	id <S265315AbRF0RJq>; Wed, 27 Jun 2001 13:09:46 -0400
Message-ID: <FEEBE78C8360D411ACFD00D0B7477971880ACD@xsj02.sjs.agilent.com>
From: "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
        "MEHTA,HIREN (A-SanJose,ex1)" <hiren_mehta@agilent.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: failed kernel 2.4.2 build after applying the patch ac28
Date: Wed, 27 Jun 2001 11:09:41 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

then why the kernel build is failing ?

-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Wednesday, June 27, 2001 4:02 AM
To: hiren_mehta@agilent.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: failed kernel 2.4.2 build after applying the patch ac28


> *** Install db development libraries
> I thought kernel build should be independent of any userland libraries.

The kernel is, the tools are not
