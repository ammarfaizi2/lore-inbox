Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280647AbRKBKtE>; Fri, 2 Nov 2001 05:49:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280648AbRKBKsy>; Fri, 2 Nov 2001 05:48:54 -0500
Received: from idefix.linkvest.com ([194.209.53.99]:35077 "EHLO
	idefix.linkvest.com") by vger.kernel.org with ESMTP
	id <S280647AbRKBKsp> convert rfc822-to-8bit; Fri, 2 Nov 2001 05:48:45 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
Content-Class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Swap question
Date: Fri, 2 Nov 2001 11:48:59 +0100
Message-ID: <B45465FD9C23D21193E90000F8D0F3DF0178FFE8@mailsrv.linkvest.com>
Thread-Topic: Swap question
Thread-Index: AcFji/otQF/YXDkET+iyVA1LU3Izqg==
From: "Jean-Eric Cuendet" <Jean-Eric.Cuendet@linkvest.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I just hear that Swap is not handled identically in Rik VM/AA VM/2.2 VM.

I use -ac kernels (with Rik's VM). Could someone precise what exactly
happens when I have:
- 256Mb RAM + 512Mb Swap
- 512Mb RAM + 512Mb Swap
- 1Gb RAM + 512Mb Swap
- 1Gb RAM + 1.2Gb Swap
How many swap is available to applications in each case?

Thanks a lot
-jec

PS: Could you please send me directly the answer, I'm not in the list.

