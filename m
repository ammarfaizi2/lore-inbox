Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267918AbTBYTtG>; Tue, 25 Feb 2003 14:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268032AbTBYTtG>; Tue, 25 Feb 2003 14:49:06 -0500
Received: from ms-smtp-02.tampabay.rr.com ([65.32.1.39]:31187 "EHLO
	ms-smtp-02.tampabay.rr.com") by vger.kernel.org with ESMTP
	id <S267918AbTBYTtE>; Tue, 25 Feb 2003 14:49:04 -0500
From: "Scott Robert Ladd" <scott@coyotegulch.com>
To: "Chris Wedgwood" <cw@f00f.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Larry McVoy" <lm@bitmover.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Minutes from Feb 21 LSE Call
Date: Tue, 25 Feb 2003 14:59:05 -0500
Message-ID: <FKEAJLBKJCGBDJJIPJLJMEOOEPAA.scott@coyotegulch.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20030225051956.GA18302@f00f.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> > The definitive Linux box appears to be $199 from Walmart right now,
> > and its not SMP.
>
> In two year this kind of hardware probably will be SMP (HT or some
> variant).

HT is not the same thing as SMP; while the chip may appear to be two
processors, it is actually equivalent 1.1 to 1.3 processors, depending on
the application.

Multicore processors and true SMP systems are unlikely to become mainstream
consumer items, given the premium price charged for such systems.

That given, I see some value in a stripped-down, low-overhead,
consumer-focused Linux that targets uniprocessor and HT systems, to be used
in the typical business or gaming PC. I'm not sure such is achievable with
the current config options; perhaps I should try to see how small a kernel I
can build for a simple ia32 system...

..Scott

Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)
Professional programming for science and engineering;
Interesting and unusual bits of very free code.

