Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267881AbTB1OCU>; Fri, 28 Feb 2003 09:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267884AbTB1OCU>; Fri, 28 Feb 2003 09:02:20 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:53252 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S267881AbTB1OCT>; Fri, 28 Feb 2003 09:02:19 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302281413.h1SED1Hm000634@81-2-122-30.bradfords.org.uk>
Subject: Re: syslog full of kernel BUGS, frequent intermittent instability
To: redelm@ev1.net (Robert Redelmeier)
Date: Fri, 28 Feb 2003 14:13:01 +0000 (GMT)
Cc: vga@port.imtp.ilyichevsk.odessa.ua, coyote1@cytanet.com.cy,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030228134700.GA15589@adsl-66-140-130-38.dsl.hstntx.swbell.net> from "Robert Redelmeier" at Feb 28, 2003 07:47:00 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You have bad hardware.  You must expect trouble.  Linux runs hardware
> pretty hard.  Correctness then Performance appears to be Linus'
> philosophy. If you are lucky, you can down-clock your bus.  If you
> are _very_ lucky, a kernel without any K6 optimizations [compiled for
> a 386] in the `bzero` and `bcopy` routines might reduce your error
> frequency.  But if X detects and uses K6 routines, you're hosed.

Also, try re-seating your RAM chips, and make sure that the CPU fan
and heatsink are free of dust and properly attached to the CPU.

John.
