Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318372AbSGRWQd>; Thu, 18 Jul 2002 18:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318368AbSGRWQd>; Thu, 18 Jul 2002 18:16:33 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:41996 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318370AbSGRWQc>; Thu, 18 Jul 2002 18:16:32 -0400
Date: Thu, 18 Jul 2002 19:19:17 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Robert Love <rml@tech9.net>
cc: Guillaume Boissiere <boissiere@adiglobal.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
In-Reply-To: <1027010370.1555.113.camel@sinai>
Message-ID: <Pine.LNX.4.44L.0207181917440.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jul 2002, Robert Love wrote:

> > After feature freeze:
>
> Easily 90% of this stuff should _not_ go in after the freeze.  It either
> needs to make it in now or hold its breath until 2.7.
>
> I would much prefer a rush of merges now and less "improper" merges
> after the freeze.  In fact, I do not care much what we do now as long as
> we treat the freeze as a freeze and work solely to stabilize stuff.

Agreed. What we need is a 2.6 that is relatively easy to
stabilise, not one that'll take until 2.6.20 to become
stable.

If some of the other features turn out to be needed, they
can always be backported from 2.7.  In fact, backporting
from 2.7 is probably _quicker_ than throwing in too many
features just before the feature freeze and then try to
stabilise them all at once together...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

