Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131329AbRABUtl>; Tue, 2 Jan 2001 15:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131386AbRABUtf>; Tue, 2 Jan 2001 15:49:35 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:25604 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131329AbRABUtJ>; Tue, 2 Jan 2001 15:49:09 -0500
Subject: Re: Error compiling 2.4 with CVS gcc on Athlon
To: ghad@triad.rr.com (Ghadi Shayban)
Date: Tue, 2 Jan 2001 20:20:50 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A523635.8080003@triad.rr.com> from "Ghadi Shayban" at Jan 02, 2001 03:12:37 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14DXvQ-0002pz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have no idea, but I'm guessing this isn't a gcc bug.  Here's where my 
> build fails:
> {standard input}: Assembler messages:
> {standard input}:139: Error: bad register name `%%mm0'

Your compiler/binutils are too old
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
