Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263832AbTLJR4k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 12:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263843AbTLJR4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 12:56:40 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:58804 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263832AbTLJR43
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 12:56:29 -0500
Date: Wed, 10 Dec 2003 09:56:14 -0800
From: Larry McVoy <lm@bitmover.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Larry McVoy <lm@bitmover.com>, Andre Hedrick <andre@linux-ide.org>,
       Arjan van de Ven <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       Kendall Bennett <KendallB@scitechsoft.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031210175614.GH6896@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
	Andre Hedrick <andre@linux-ide.org>,
	Arjan van de Ven <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
	Kendall Bennett <KendallB@scitechsoft.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10312100550500.3805-100000@master.linux-ide.org> <Pine.LNX.4.58.0312100714390.29676@home.osdl.org> <20031210153254.GC6896@work.bitmover.com> <Pine.LNX.4.58.0312100809150.29676@home.osdl.org> <20031210163425.GF6896@work.bitmover.com> <Pine.LNX.4.58.0312100852210.29676@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312100852210.29676@home.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 09:10:18AM -0800, Linus Torvalds wrote:
> On Wed, 10 Dec 2003, Larry McVoy wrote:
> > Which is?  How is it that you can spend a page of text saying a judge doesn't
> > care about technicalities and then base the rest of your argument on the
> > distinction between a "plugin" and a "kernel module"?
> 
> I'll stop arguing, since you obviously do not get it.

Err, I think people might say you are punting.  You claim that there is a
difference between a plugin and a kernel module, I ask what, you say 
"I'll stop arguing because you don't get it".  Hmm.  

> But if you want to explain something to a judge, you get a real lawyer,
> and you make sure that the lawyer tries to explain the issue in _non_
> technical terms. Because, quite frankly, the judge is not going to buy a
> technical discussion he or she doesn't understand.

Exactly.  I agree.  And the lawyer is going to make mincemeat of your
argument that there is a difference between a flash plugin and a driver.

> In short, your honour, this extra chapter without any meaning on its own
> is a derived work of the book.

I see.  And your argument, had it prevailed 5 years ago, would have
invalidated the following, would it not?  The following from one of the
Microsoft lawsuits.

>From http://ecfp.cadc.uscourts.gov/MS-Docs/1636/0.pdf

    Substituting an alternative module for one supplied by Microsoft
    may not violate copyright law, and certainly not because of any
    "integrity of the work" argument. The United States recognizes "moral
    rights" of attribution and integrity only for works of visual art
    in limited editions of 200 or fewer copies. (See 17 U.S.C. 106A
    and the definition of "work of visual art" in 17 U.S.C. 101.) A
    bookstore can replace the last chapter of a mystery novel without
    infringing its copyright, as long as they are not reprinting the
    other chapters but are simply removing the last chapter and replacing
    it with an alternative one, but must not pass the book off as the
    original. Having a copyright in a work does not give that copyright
    owner unlimited freedom in the terms he can impose.

Start to see why I think what you are doing is dangerous and will backfire?

Note that the GPL does allow "reprinting" (that's section 1).  So any
"alternative" stuff can be added *and* distributed *together* with the
original stuff.  And, of course, the "alternative" added stuff doesn't
need to be under the GPL as long as the added stuff is NOT a derivative
work of the GPL'd thing (read: was prepared without copying any protected
elements from the GPL'd thing [clean room] or simply doesn't contain
them at all being a completely different [new] functional part of "a
whole" work).

>From http://www-106.ibm.com/developerworks/opensource/library/os-cplfaq.html

    Q: If I write a module to add to a Program licensed under the CPL
    and distribute the object code of the module along with the rest of
    the Program, must I make the source code to my module available in
    accordance with the terms of the CPL?

    A: No, as long as the module is not a derivative work of the Program.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
