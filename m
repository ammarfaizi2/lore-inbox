Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269133AbTGZChi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 22:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269144AbTGZChi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 22:37:38 -0400
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:24506 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S269133AbTGZChh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 22:37:37 -0400
Date: Sat, 26 Jul 2003 04:52:46 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: Larry McVoy <lm@bitmover.com>
Subject: Re: Switching to the OSL License, in a dual way.
Message-ID: <20030726025246.GA30151@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Larry McVoy <lm@bitmover.com>
References: <pan.2003.07.24.18.06.06.546220@terra.com.br> <Pine.LNX.4.10.10307241256360.16098-100000@master.linux-ide.org> <pan.2003.07.24.21.05.40.969654@terra.com.br> <20030724215744.GA7777@work.bitmover.com> <plopm3wue72alp.fsf@drizzt.kilobug.org> <20030725143933.GA13840@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030725143933.GA13840@work.bitmover.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jul 2003, Larry McVoy wrote:

> > This is  exactly the  same. As  long as there  is a  data format  or a
> > protocol involved,  European laws allow users to  reverse engineer it,
> > to  be  able to  create  another program  using  the  same format  and
> > protocols. 
> 
> Really?  Show me that law please.

IANAL, but check the "German Gesetz über Urheberrecht und verwandte
Schutzrechte" (Urheberrechtsgesetz/UrhG for short), §§ 69c, 69d, 69e.
http://bundesrecht.juris.de/bundesrecht/urhg/index.html

It concerns itself with "interoperability" of independently developed
programs with an existing one that you may use, (not with clones though,
the law formulates this differently); decompilation is allowed, unless
information needed to obtain interoperability is available, and there
are other restrictions.  License or contract clauses that attempt to run
counter to §69d 2,3 (backup copies to ensure future use) or §69e
(decompilation) are void.

Anyone interested should check out the exact words of the law though,
and in particular he should not rely on my translation.

