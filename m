Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290892AbSASAzX>; Fri, 18 Jan 2002 19:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290893AbSASAzJ>; Fri, 18 Jan 2002 19:55:09 -0500
Received: from mail.mojomofo.com ([208.248.233.19]:53258 "EHLO mojomofo.com")
	by vger.kernel.org with ESMTP id <S290892AbSASAyw>;
	Fri, 18 Jan 2002 19:54:52 -0500
Message-ID: <014501c1a083$e5c44650$58dc703f@bnscorp.com>
From: "Aaron Tiensivu" <mojomofo@mojomofo.com>
To: "Tim Moore" <timothymoore@bigfoot.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <00c201c1a033$1cf46700$b71c64c2@viasys.com> <3C48BF64.FBF58C7C@bigfoot.com>
Subject: Re: VIA KT133 & HPT 370 IDE disk corruption
Date: Fri, 18 Jan 2002 19:54:48 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My BP6's [hpt366] had similar sustained I/O lockup issues, especially
> when running a RAID stripe.  From the v1.01 BP6 manual:

Unfortunately, I suspect that is due to the older HPT drivers still in the
current kernels (the HPT366 is a very broken beast by design, and from what
I've gathered from others, is that Abit did poor job connecting it into the
BP6)

Another reason for those lockups could be due to the noisy APIC bus on the
BP6.

As much as I love my BP6, as an "ultimate dirty hack not approved by Intel"
motherboard, it has its flaws.
I'm just thankful it is still running. :)


