Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261802AbSIXVJX>; Tue, 24 Sep 2002 17:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261801AbSIXVJX>; Tue, 24 Sep 2002 17:09:23 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56072 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261802AbSIXVJV>; Tue, 24 Sep 2002 17:09:21 -0400
Date: Tue, 24 Sep 2002 17:06:57 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: jbradford@dial.pipex.com
cc: Padraig Brady <padraig.brady@corvil.com>, linux-kernel@vger.kernel.org
Subject: Re: hdparm -Y hangup
In-Reply-To: <200209230944.g8N9iN83000129@darkstar.example.net>
Message-ID: <Pine.LNX.3.96.1020924170534.19732B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Sep 2002 jbradford@dial.pipex.com wrote:

> > Hrm, OK thanks for the info. Perhaps it should be removed
> > from hdparm or a (DANGEROUS) put beside the description
> > until it's fixed.
> 
> The person to contact would be Mark Lord, the hdparm maintainer, (see the hdparm manual page for his E-Mail address).

Rather than have Mark Lord set the option DANGEROUS (it shouldn't be)
perhaps it could be made to work more than once...  Odd problem, is
something not getting set or cleared when the drive is spun up the first
time?

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

