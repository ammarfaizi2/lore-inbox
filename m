Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136500AbRAHBxk>; Sun, 7 Jan 2001 20:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136502AbRAHBxV>; Sun, 7 Jan 2001 20:53:21 -0500
Received: from cx518206-b.irvn1.occa.home.com ([24.21.107.123]:50692 "EHLO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with ESMTP
	id <S136500AbRAHBxP>; Sun, 7 Jan 2001 20:53:15 -0500
From: "Barry K. Nathan" <barryn@cx518206-b.irvn1.occa.home.com>
Message-Id: <200101080153.RAA02326@cx518206-b.irvn1.occa.home.com>
Subject: Re: [PATCH] new bug report script
To: juchem@uni-mannheim.de
Date: Sun, 7 Jan 2001 17:53:04 -0800 (PST)
Cc: drepper@cygnus.com (Ulrich Drepper), kaos@ocs.com.au (Keith Owens),
        linux-kernel@vger.kernel.org
Reply-To: barryn@pobox.com
In-Reply-To: <Pine.LNX.4.30.0101080237070.16904-100000@gandalf.math.uni-mannheim.de> from "Matthias Juchem" at Jan 08, 2001 02:40:34 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Juchem wrote:
> BTW, lots of version dependencies found in older Changes document (i.e.
> for 2.3.11) were removed now (2.4.0 shows only 9 where the old one had
> 22). Have the removed ones been completely unnecessary?

Quoting from 2.4.0's Changes file:
[snip]
> trying life on the Bleeding Edge.  If upgrading from a pre-2.2.x
> kernel, please consult the Changes file included with 2.2.x kernels for
> additional information; most of that information will not be repeated
> here.  Basically, this document assumes that your system is already
> functional and running at least 2.2.x kernels.

Perhaps that accounts for the missing version dependencies...

-Barry K. Nathan <barryn@pobox.com>
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
