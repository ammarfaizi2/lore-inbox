Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267732AbUHJVON@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267732AbUHJVON (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267727AbUHJVON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:14:13 -0400
Received: from mail2.uklinux.net ([80.84.72.32]:52674 "EHLO mail2.uklinux.net")
	by vger.kernel.org with ESMTP id S267707AbUHJVOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:14:00 -0400
From: Nick Warne <nick@linicks.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Bug zapper?  :)
Date: Tue, 10 Aug 2004 22:13:56 +0100
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408102213.56383.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"I'm suggesting things to make code auditing simpler, more accurate, more 
precise.  "Quality-Assurance audited code still contains on average 5 
bugs per kloc" is a really nasty thought."

I really disagree with stuff like this.

OK, I am not a contributer to kernel code - far from it - nor really any sort 
of coder at all except I can read it all and try to understand.

But why does 'quality assurance' == less bugs (or whatever you try it on - and 
take we know who for an e.g.)?

It doesn't.  All it does is give a 'false' assurance to something that when 
tested and looked at didn't find what it was searching for to look at and 
find - and of course, who/whatever does the assessment needs to be 'QA'ed' 
first to make sure that is correct - so what/who does that?

If the code is 'Assured clean' then should everybody accept it and carry on to 
the next bit?

Quality assurance may work in the manufacturing industry (sort of), but in 
abstract fluent work...

Many eyes is the only way, reading and re-reading.

Nick


-- 
"When you're chewing on life's gristle,
Don't grumble, Give a whistle..."
