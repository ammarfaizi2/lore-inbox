Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272670AbRHaL6D>; Fri, 31 Aug 2001 07:58:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272671AbRHaL5x>; Fri, 31 Aug 2001 07:57:53 -0400
Received: from mailout6-1.nyroc.rr.com ([24.92.226.177]:2260 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S272670AbRHaL5n>; Fri, 31 Aug 2001 07:57:43 -0400
Message-ID: <029401c13214$6b2cd700$1a01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "Hans-Christian Armingeon" <johnny@allesklar.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.ctkbovv.a626og@ifi.uio.no>
Subject: Re: ieee1394 broken?
Date: Fri, 31 Aug 2001 07:59:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> my box (via kt133 thunderbird 1g 256mb 2.4.9-ac3) hangs
> completely up, when I insert ohci1394.

This bug is fixed in the linux1394 CVS
(http://linux1394.sourceforge.net/cvs.html). Ben Collins will be forwarding
the fix to Linus soon.

Dan

