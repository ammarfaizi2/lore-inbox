Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265089AbTFUHrL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 03:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265090AbTFUHrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 03:47:11 -0400
Received: from bart.one-2-one.net ([217.115.142.76]:25613 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S265089AbTFUHrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 03:47:08 -0400
Date: Sat, 21 Jun 2003 10:01:41 +0200 (CEST)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: Troll Tech [was Re: Sco vs. IBM]
In-Reply-To: <20030620120910.3f2cb001.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.44.0306201258140.10892-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jun 2003, Stephan von Krawczynski wrote:

> GPL has an inherent long-term strategy, you are talking of short-term,
> Larry. That does not match. If I am using only GPL-software I know I am
> able to use it as is in five years from now.

Really? Are you sure it would still compile with gcc-5.1.7 at that time? 
Are you sure somebody will take care it will still work with latest 
hardware then? Are you sure somebody will fix all the security issues 
which came up over the years? Are you sure somebody will help you out in 
case you are stuck with a new problem then?

Do you feel comfortable depending on that helpful unknown somebody? What 
if the one who released the stuff doesn't support it any longer because he 
gave away the hardware or got tired having to fix his stuff over and over 
again due to api volatility even months after so-called feature freeze or 
simply due to changed personal preferences?

Of course, you are still better of with the GPL'ed sources available but 
this alone doesn't buy you anything. In real world the difference between 
"still possible to support" (thanks to GPL f.e.) and "getting good 
(relyable in quality and time) support" tends to be non-trivial ;-)

So I don't see any long term strategy there inherent in the GPL. Simply 
throwing RTFS in front of the people is definitedly better than nothing, 
but doesn't qualify as a strategy to me. But maybe I'm missing something.

> If I depend on being nice to commercial
> companies, it may well turn out, that they are not being nice to me no matter
> what I do.

Well, as a test you might want to try asking (say here on lkml) to get the 
GPL'ed defxx-driver working. I might be wrong but it may well turn out 
nobody would be nice doing it for you, no matter what you do ;-)

> In other words: it's all about being free or being dependant on goodwill.

Nope, at least from a user's POV: While you are always free to decide to 
use it or not - you are always depending on somebody providing you the 
support you need to keep the stuff working for you...

For somebody willing and capable to do the maintenance himself it's still 
imposing some dependency/constraint to him, because one needs to allocate 
time to both keep up with the development process and do the actual work. 
Which in turn means being dependent on other people's or institutions' 
goodwill so you can afford said amount of time.

Martin

