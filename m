Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265116AbRFUTEu>; Thu, 21 Jun 2001 15:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265117AbRFUTEo>; Thu, 21 Jun 2001 15:04:44 -0400
Received: from srv01s4.cas.org ([134.243.50.9]:11409 "EHLO srv01.cas.org")
	by vger.kernel.org with ESMTP id <S265118AbRFUTEb>;
	Thu, 21 Jun 2001 15:04:31 -0400
From: Mike Harrold <mharrold@cas.org>
Message-Id: <200106211904.PAA10433@mah21awu.cas.org>
Subject: Re: Controversy over dynamic linking -- how to end the panic
To: ttabi@interactivesi.com (Timur Tabi)
Date: Thu, 21 Jun 2001 15:04:21 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <qi1bhC.A.lfF.ZEkM7@dinero.interactivesi.com> from "Timur Tabi" at Jun 21, 2001 01:46:48 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> To be honest, I disagree that #include'ing a GPL header file should force your
> app to be GPL as well.  That may be how the license reads, but I think it's a
> very bad idea.  I could write 1 million lines of original code, but if someone
> told me that but simply adding #include <stdio.h> my code is now a derivative of
> the stdio.h, I'd tell him to go screw himself.

Not to mention utterly unenforceable. Consider:

1) Oracle Corp. builds their database for Linux on a Linux system.
2) Said system comes with standard header files, which happen in this case to
   be GPL'd header files.
3) Oracle Corp.'s database becomes GPL.

There's not a court in the civilised world that would uphold the GPL in that
scenario.

Regards,

/Mike
