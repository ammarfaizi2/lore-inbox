Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289326AbSA3Ps4>; Wed, 30 Jan 2002 10:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289327AbSA3Psq>; Wed, 30 Jan 2002 10:48:46 -0500
Received: from rudy.mif.pg.gda.pl ([153.19.42.16]:17156 "EHLO
	rudy.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S289326AbSA3Psh>; Wed, 30 Jan 2002 10:48:37 -0500
Date: Wed, 30 Jan 2002 16:48:14 +0100 (CET)
From: =?ISO-8859-2?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>
To: Ingo Molnar <mingo@elte.hu>
cc: Rob Landley <landley@trommello.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <Pine.LNX.4.33.0201291324560.3610-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0201301635370.13037-100000@rudy.mif.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Ingo Molnar wrote:
[..]
> 1) cleanliness
> 
> code cleanliness is a well-know issue, see Documentation/CodingStyle.  If
> a patch has such problems then maintainers are very likely to help - Linus
> probably wont and shouldnt.

I think place in each directory .indent.pro file with proper coding style
configuration and reduce Documentation/CodingStyle to how to use indent
tool can will solve many currunt problems with proper patches form and
will probaly take smaller amout disk space (or aprox the same) than
current Documentation/CodingStyle. Even if current indent can't handle
correctly current kernel coding style IMHO it will be better inves few
minutes on some changes to current indent behavior for bring this tool
abilities for reindent source code in way described in
Documentation/CodingStyle .. (?)

kloczek
-- 
-----------------------------------------------------------
*Ludzie nie maj± problemów, tylko sobie sami je stwarzaj±*
-----------------------------------------------------------
Tomasz K³oczko, sys adm @zie.pg.gda.pl|*e-mail: kloczek@rudy.mif.pg.gda.pl*

