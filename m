Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288957AbSAZCMn>; Fri, 25 Jan 2002 21:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288979AbSAZCMX>; Fri, 25 Jan 2002 21:12:23 -0500
Received: from mailout5-0.nyroc.rr.com ([24.92.226.122]:18380 "EHLO
	mailout5.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S288957AbSAZCMN>; Fri, 25 Jan 2002 21:12:13 -0500
Message-ID: <037801c1a60e$d897e230$1d01a8c0@allyourbase>
From: "Dan Maas" <dmaas@dcine.com>
To: "Andreas Schwab" <schwab@suse.de>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <fa.juevf8v.1u7ubb8@ifi.uio.no> <fa.h3u09pv.1v2k3bm@ifi.uio.no>
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
Date: Fri, 25 Jan 2002 21:12:03 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> These are all startup costs that are lost in the noise
> the longer the program runs.

This may be true for environments where people mostly run a handful of
monolithic applications (*ahem* windows) but look at typical Linuxy things
like:

make (compiler, assembler, linker processes...)
forking servers (Apache 1.x...)
*./configure scripts* (a big one!!!)
etc...

Startup cost is likely to be a big factor here...

Regards,
Dan

