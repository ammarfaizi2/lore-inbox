Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268144AbRGaQPl>; Tue, 31 Jul 2001 12:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269347AbRGaQPc>; Tue, 31 Jul 2001 12:15:32 -0400
Received: from atlrel2.hp.com ([156.153.255.202]:62955 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S268144AbRGaQPX>;
	Tue, 31 Jul 2001 12:15:23 -0400
Message-ID: <3B66D9B9.A01685AB@fc.hp.com>
Date: Tue, 31 Jul 2001 10:15:53 -0600
From: Khalid Aziz <khalid@fc.hp.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
Cc: Linux kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Support for serial console on legacy free machines
In-Reply-To: <200107302240.f6UMeWg2001230@webber.adilger.int> <31754.996543218@kao2.melbourne.sgi.com> <20010730215002.I1275@valinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

We are moving slightly off of my original question which still stands.
For machines that do have serial ports but not at legacy addresses
(COM1, COM2,....), is it acceptable to use the description of these
ports as provided by SPCR and DBGP tables even though Microsoft claims
copyright on these tables and retains the option to modify these tables
at any time? Would it be preferable to use a table defined as part of a
standard like ACPI 2.0 or DIG64 (such a table does not exist at this
time but with enough votes for it, it may be added)? 

-- 
Khalid

====================================================================
Khalid Aziz                              Linux Systems Operation R&D
(970)898-9214                                        Hewlett-Packard
khalid@fc.hp.com                                    Fort Collins, CO
