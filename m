Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275963AbRJKKL0>; Thu, 11 Oct 2001 06:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275968AbRJKKLQ>; Thu, 11 Oct 2001 06:11:16 -0400
Received: from oe76.law9.hotmail.com ([64.4.8.211]:27396 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S275963AbRJKKLM>;
	Thu, 11 Oct 2001 06:11:12 -0400
X-Originating-IP: [66.108.21.174]
From: "Concerned Programmer" <tkhoadfdsaf@hotmail.com>
To: =?iso-8859-1?Q?Pekka_Pietik=E4inen?= <pp@netppl.fi>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <20011011105016.C28145@devcon.net> <E15rc5o-0002cH-00@the-village.bc.nu> <9q3p56$tqo$1@forge.intermeta.de> <20011011124144.A20659@netppl.fi>
Subject: Re: Tainted Modules Help Notices
Date: Thu, 11 Oct 2001 06:09:35 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE76YXYdLPJYkamGn3V0000d7ce@hotmail.com>
X-OriginalArrivalTime: 11 Oct 2001 10:11:38.0407 (UTC) FILETIME=[1D798370:01C1523D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    If this is about maintainability, why not just a simple flag stating if
source is available or not.

PS.

    Would be even nicer if it defaulted to "true" so my (and others') old
module source code did not now have to be changed just to avoid the annoying
warning from modprobe, though I assume thats out of the question.

> > "included in kernel" could also be a 3rd party binary only driver
> > added by a Linux distribution vendor.
> Or even something like "BSD (unmodified source freely available)", which
> would cover 3rd party drivers as well.

