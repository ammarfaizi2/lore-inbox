Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287612AbSABN64>; Wed, 2 Jan 2002 08:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287624AbSABN6q>; Wed, 2 Jan 2002 08:58:46 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:28365 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S287612AbSABN6b>; Wed, 2 Jan 2002 08:58:31 -0500
Date: 02 Jan 2002 11:59:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8G6n2tI1w-B@khms.westfalen.de>
In-Reply-To: <20020102013411.A5968@werewolf.able.es>
Subject: Re: a great C++ book?
X-Mailer: CrossPoint v3.12d.kh8 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20020101104331.F4802@work.bitmover.com> <20020101041111.29695.qmail@web14310.mail.yahoo.com> <Pine.LNX.4.43.0201011214560.7188-100000@waste.org> <20020101104331.F4802@work.bitmover.com> <20020102013411.A5968@werewolf.able.es>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jamagallon@able.es (J.A. Magallon)  wrote on 02.01.02 in <20020102013411.A5968@werewolf.able.es>:

> On 20020101 Larry McVoy wrote:
> >
> >Makes you wonder what would happen if someone tried to design a
> >minimalistic C++, call it the "M programming language", have be close
> >to C with the minimal useful parts of C++ included.
> >
>
> There are specs for something called 'Embedded C++'. You can run it on
> a cell phone, so it looks like little bloated...

Wrong metric, unless you mean you can run the *compiler* on the cell  
phone.

c99.pdf:   1412026 bytes
c++98.pdf: 2860601 bytes

And remember that interactions between features go up exponentially.

I think one of the worst design decisions for C++ (hindsight, of course)  
was to keep compatibility with C. The other bad one was to accept too many  
new features.

The Modula-3 standard (that's an OO variant of Modula-2) had as a language  
design goal that the language description should not take more than 50  
pages. They overshot that, but it still was much less than 100 (somewhat  
less precise than C/C++, admittedly). As a result, that language (and  
consequently, programs in that language) is *much* easier to understand  
than C++.

That doesn't mean I'm in love with Modula-3. Actually, I don't even use  
it, and I do think (hindsight again) some of the design decisions were  
unfortunate. But I do think keeping an eye on the sheer mass of the spec  
is a good idea.

MfG Kai
