Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266224AbSLSVfu>; Thu, 19 Dec 2002 16:35:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266233AbSLSVfu>; Thu, 19 Dec 2002 16:35:50 -0500
Received: from [81.2.122.30] ([81.2.122.30]:2314 "EHLO darkstar.example.net")
	by vger.kernel.org with ESMTP id <S266224AbSLSVfu>;
	Thu, 19 Dec 2002 16:35:50 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200212192155.gBJLtV6k003254@darkstar.example.net>
Subject: Re: Dedicated kernel bug database
To: rddunlap@osdl.org (Randy.Dunlap)
Date: Thu, 19 Dec 2002 21:55:31 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L2.0212191330120.30841-100000@dragon.pdx.osdl.net> from "Randy.Dunlap" at Dec 19, 2002 01:32:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> | > I'm not trying to discourage you - just raising a potential gotcha.
> |
> | Overall, though, would you rather be presented with a list of
> | categories, or a list of people and what parts of the code they
> | maintain.  Personally, I think that a list of people is more
> | intuitive, rather than an abstract list of categories, but I could be
> | wrong.
> 
> Do we have anyone targeted for interrupt routing problems (PIC, IO APIC,
> ACPI, etc.)?

No.  I nominate Alan :-).

OK, I see your point, but no bug system will ever be perfect.  Does
that mean there is no point in trying to make a better one?  If
everybody really thinks it's a waste of time, I won't bother.  It just
seemed to me that we need something less generic than Bugzilla.  Maybe
I am wrong, I don't know.

John.
