Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261173AbRFORpT>; Fri, 15 Jun 2001 13:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264213AbRFORpJ>; Fri, 15 Jun 2001 13:45:09 -0400
Received: from [64.170.218.78] ([64.170.218.78]:16900 "EHLO orion.ariodata.com")
	by vger.kernel.org with ESMTP id <S261173AbRFORoz> convert rfc822-to-8bit;
	Fri, 15 Jun 2001 13:44:55 -0400
Subject: RE2: kmalloc
Date: Fri, 15 Jun 2001 10:41:59 -0700
Message-ID: <8A098FDFC6EED94B872CA2033711F86F01A9A2@orion.ariodata.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Thread-Topic: RE2: kmalloc
Thread-Index: AcD1v3KlkoUXj9MIQWKKl5hfhE0Mjg==
From: "Michael Nguyen" <mnguyen@ariodata.com>
To: "David S. Miller" <davem@redhat.com>, "Petko Manolov" <pmanolov@Lnxw.COM>
content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

>>Petko Manolov writes:
>> kmalloc fails to allocate more than 128KB of
>> memory regardless of the flags (GFP_KERNEL/USER/ATOMIC)
>> 
>> Any ideas?

>Yes, this is the limit.

Im relatively new to Linux. I would like to ask.
Is this limit per kmalloc()? Can I do this multiple times?

TX,
Michael Nguyen
mnguyen@ariodata.com
