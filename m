Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264944AbTFCGn4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 02:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264946AbTFCGn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 02:43:56 -0400
Received: from xs4all.vs19.net ([213.84.236.198]:16462 "EHLO spaans.vs19.net")
	by vger.kernel.org with ESMTP id S264944AbTFCGnz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 02:43:55 -0400
Date: Tue, 3 Jun 2003 08:56:39 +0200
From: Jasper Spaans <jasper@vs19.net>
To: Larry McVoy <lm@work.bitmover.com>, Aaron Lehmann <aaronl@vitelus.com>,
       Rob Landley <rob@landley.net>, linux-kernel@vger.kernel.org
Subject: Re: BKCVS issue
Message-ID: <20030603065639.GA5093@spaans.vs19.net>
References: <20030602211436.GF14878@vitelus.com> <200306021937.03013.rob@landley.net> <20030603003739.GG14878@vitelus.com> <20030603022859.GA26322@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20030603022859.GA26322@work.bitmover.com>
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2003 C. Jasper Spaans - All Rights Reserved
X-message-flag: Warning! The sender of this mail thinks you should use a more secure email client!
Keywords: Qaddafi counter-intelligence White Water ammunition strategic spy NSA 
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 02, 2003 at 07:28:59PM -0700, Larry McVoy wrote:

> It is intelligent but it is busted, believe me, I know.  The conversion
> happens on my desktop and it thrashes the hell out of the disk when
> CVS tags.
> 
> We're swamped working on a BK release, that's our first priority.  As soon
> as I get a breather I'll get back to the bk2cvs convertoer.

Just a small pointer which might help, when looking at the cvslog of any
file in the bkcvs repository:

RCS file: /home/cvs/linux-2.5/Makefile,v
Working file: Makefile
head: 1.376
branch:
locks: strict
access list:
symbolic names:
        found: 1.376
        not: 1.376
        command: 1.376
        v2_5_70: 1.356
[...]

So it seems something is b0rken wrt tagging...

Otherwise it's a mighty fine service, thanks a lot for providing it.


Bye,
-- 
Jasper Spaans
http://jsp.vs19.net/contact/

``Got no clue? Too bad for you.''
