Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262966AbVAFSQf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262966AbVAFSQf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 13:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262931AbVAFSOm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 13:14:42 -0500
Received: from tag.witbe.net ([81.88.96.48]:19920 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S262955AbVAFSJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 13:09:20 -0500
Message-Id: <200501061808.j06I84104393@tag.witbe.net>
Reply-To: <rol@as2917.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Willy Tarreau'" <willy@w.ods.org>, "'Theodore Ts'o'" <tytso@mit.edu>,
       "'Horst von Brand'" <vonbrand@inf.utfsm.cl>,
       "'Thomas Graf'" <tgraf@suug.ch>, "'Bill Davidsen'" <davidsen@tmr.com>,
       "'Adrian Bunk'" <bunk@stusta.de>,
       "'Diego Calleja'" <diegocg@teleline.es>, <wli@holomorphy.com>,
       <aebr@win.tue.nl>, <solt2@dns.toxicfilms.tv>,
       <linux-kernel@vger.kernel.org>
Subject: Re: starting with 2.7
Date: Thu, 6 Jan 2005 19:08:04 +0100
Organization: AS2917
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
In-Reply-To: <20050104214324.GG22075@alpha.home.local>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcTyqcHqiJFa1qRURJmAv4SD7Vq9sQBb4h2A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> > In practice, that's all the -rc releases are these days 
> anyway (there
> > are times when a 2.6.x-rcy release is more stable than 2.6.z).  The
> > problem is that since the -rc releases are called what they are
> > called, they don't get enough testing.
> 
> Perfectly true. I would add that with -rc releases, people 
> only upgrade when
> we tell them that they can, while with more frequent 
> releases, they upgrade
> when they *need* to, and can try several versions if the 
> first one they pick
> does not work.
> 

I'd like to add some personal view : After 2.4.x, we have had a fork and
2.5.x was born, clearly identified as a development tree, so no stability
guaranteed... Then one day came 2.6.0, and so on...
I'm sorry, but I still cannot consider 2.6.x being any stable the way 2.4.x
is today.

Theodore wrote :
> that at least 1 in 3 releases will turn out to be stable enough for
> most purposes.  But we won't know until after 2 or 3 days which
> releases will be the good ones.

I mostly agree. When a new 2.4.x comes out, I have a confident feeling
about it, and there is no reason for me to wait 2 or 3 days to know if 
it's stable or not. It's part of a stable branch, and there are no
major changes in it.
2.6.x, I still consider as a development branch. OK, people changed the
numbering from 2.5.x to 2.6.x, but the number of changes still going on
didn't really change. Just have a look at the numbers : patches are even
bigger now that we are in a "stable" branch (4Mo average for 2.6 patch, 
gzip when we had a 1Mo average for 2.5 !)

Yes, it is a wonderful playground. So let's keep it a playground, let
number it 2.5.x again, and play with. Or let it be a stable branch,
and do something for people needing a playground.

Paul

PS : on my personal computer, I'm a player, so I'm running 2.6.x, but don't
expect me to put that on a production server for long... No way, not yet,
not as long as the decision on what *really* is 2.6.x is clear.

