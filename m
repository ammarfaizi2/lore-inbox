Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130112AbRAGWtO>; Sun, 7 Jan 2001 17:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130308AbRAGWtE>; Sun, 7 Jan 2001 17:49:04 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:12036 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S130112AbRAGWsu>; Sun, 7 Jan 2001 17:48:50 -0500
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200101072248.OAA01920@cx518206-b.irvn1.occa.home.com>
Subject: Re: posix_types.h  error
To: mikeg@wen-online.de (Mike Galbraith)
Date: Sun, 7 Jan 2001 14:48:53 -0800 (PST)
Cc: root@chaos.analogic.com (Richard B. Johnson),
        linux-kernel@vger.kernel.org (linux-kernel)
Reply-To: barryn@pobox.com
In-Reply-To: <Pine.Linu.4.10.10101071723420.1054-100000@mikeg.weiden.de> from "Mike Galbraith" at Jan 07, 2001 06:09:23 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Galbraith wrote:
> On Sun, 7 Jan 2001, Richard B. Johnson wrote:
[snip]
> > None of the named compilers gripe? Where, prey tell, do I get the source-
> > code of a compiler that works? The only source provided in the site
> > listed in the Documentation does not.
> 
> It's not the only source there.. egcs-1.1.2 is there as well.  You can
> also try egcs.cygnus.com/pub/egcs or a mirror.

Richard is asking for source code. Documentation/Changes only gives the
location of binaries.

This is a bit of a problem IMO (I also tried, and failed, to find the egcs
1.1.2 source code). Now that I know where it is, I'll soon post a patch
for Documentation/Changes...

-Barry K. Nathan <barryn@pobox.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
