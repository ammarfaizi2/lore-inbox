Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291863AbSB0D16>; Tue, 26 Feb 2002 22:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291889AbSB0D1s>; Tue, 26 Feb 2002 22:27:48 -0500
Received: from oe43.law9.hotmail.com ([64.4.8.15]:8455 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S291863AbSB0D1d>;
	Tue, 26 Feb 2002 22:27:33 -0500
X-Originating-IP: [66.108.23.161]
From: "T. A." <tkhoadfdsaf@hotmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Florian Lohoff" <flo@rfc822.org>
In-Reply-To: <20020226184043.GA10420@paradigm.rfc822.org> <3C7BDC57.A835D657@zip.com.au> <20020226191626.GA11283@paradigm.rfc822.org>
Subject: Re: [CRASH] gdth / __block_prepare_write: zeroing uptodate buffer! / NMI Watchdog detected LOCKUP
Date: Tue, 26 Feb 2002 22:27:50 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Message-ID: <OE43IwMw8lODAStRc0J00021292@hotmail.com>
X-OriginalArrivalTime: 27 Feb 2002 03:27:28.0132 (UTC) FILETIME=[AE9A7440:01C1BF3E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    What motherboard are you using?  I recently installed a ICP RAID card
into a VP6 with dual processors and had similar problems.  I've also had
problems with the gdth driver under linux in that drives were disappearing
now and then destroying the integrity of the RAID drive, though in a
different setup.


----- Original Message -----
From: "Florian Lohoff" <flo@rfc822.org>
To: "Andrew Morton" <akpm@zip.com.au>
Cc: <linux-kernel@vger.kernel.org>
Sent: Tuesday, February 26, 2002 2:16 PM
Subject: Re: [CRASH] gdth / __block_prepare_write: zeroing uptodate buffer!
/ NMI Watchdog detected LOCKUP


