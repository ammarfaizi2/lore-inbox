Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129807AbQLUC5U>; Wed, 20 Dec 2000 21:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130127AbQLUC5K>; Wed, 20 Dec 2000 21:57:10 -0500
Received: from mauve.demon.co.uk ([158.152.209.66]:35845 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129807AbQLUC4x>; Wed, 20 Dec 2000 21:56:53 -0500
From: Ian Stirling <root@mauve.demon.co.uk>
Message-Id: <200012210226.CAA20107@mauve.demon.co.uk>
Subject: Laptop system clock slow after suspend to disk. (2.4.0-test9/hinote VP)
To: linux-kernel@vger.kernel.org
Date: Thu, 21 Dec 2000 02:26:12 +0000 (GMT)
In-Reply-To: <E148tqH-0002JQ-00@the-village.bc.nu> from "Alan Cox" at Dec 21, 2000 12:44:19 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've not noticed this on earlier kernel versions, is there something
silly I'm missing that's making my DEC hinote VP (p100 laptop)s 
system clock slow by a factor of five or so after resume?
Not the CPU or cmos clock, only the system clock.
Thoughts welcome.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
