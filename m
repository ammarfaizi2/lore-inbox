Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266397AbRGFLR1>; Fri, 6 Jul 2001 07:17:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266385AbRGFLRR>; Fri, 6 Jul 2001 07:17:17 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30481 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S266393AbRGFLRG>; Fri, 6 Jul 2001 07:17:06 -0400
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
To: helgehaf@idb.hist.no (Helge Hafting)
Date: Fri, 6 Jul 2001 12:16:00 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds), viro@math.psu.edu,
        alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <3B457AA3.D74E1FCE@idb.hist.no> from "Helge Hafting" at Jul 06, 2001 10:45:23 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ITaa-0004Ei-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am convinced.  I misunderstood, thinking there was a big change just
> for
> ACPI which I and many others don't use.  Thanks for clearing things up.

It solves a few long standing arguments too - we can slap .config in it 
ending the long standing /proc/config argument without using any ram except
when people care

