Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130252AbQK3RbD>; Thu, 30 Nov 2000 12:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130563AbQK3Raw>; Thu, 30 Nov 2000 12:30:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32520 "EHLO
        www.linux.org.uk") by vger.kernel.org with ESMTP id <S130252AbQK3RZE>;
        Thu, 30 Nov 2000 12:25:04 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200011301654.QAA01657@raistlin.arm.linux.org.uk>
Subject: Re: [PATCH] New user space serial port driver
To: R.E.Wolff@bitwizard.nl (Rogier Wolff)
Date: Thu, 30 Nov 2000 16:54:26 +0000 (GMT)
Cc: tigran@veritas.com (Tigran Aivazian),
        patrick@bitwizard.nl (Patrick van de Lageweg),
        wolff@bitwizard.nl (Rogier Wolff),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List)
In-Reply-To: <200011301647.RAA03831@cave.bitwizard.nl> from "Rogier Wolff" at Nov 30, 2000 05:47:24 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff writes:
> Documentation bug. Not code bug. 

In which case, can we put it in as a documentation fix rather than changing
the compiler output?  ie, /* = { NULL, } */ ?
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
