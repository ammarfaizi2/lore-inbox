Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263628AbTFTRl5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 13:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263631AbTFTRl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 13:41:57 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:24332 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263628AbTFTRlz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 13:41:55 -0400
Date: Fri, 20 Jun 2003 13:49:19 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Bob Tracy <rct@gherkin.frus.com>
cc: Kai Makisara <Kai.Makisara@kolumbus.fi>, linux-kernel@vger.kernel.org,
       axboe@suse.de
Subject: Re: 2.5.72: SCSI tape error handling
In-Reply-To: <20030620130834.BCA4C4F01@gherkin.frus.com>
Message-ID: <Pine.LNX.3.96.1030620134619.17843A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Jun 2003, Bob Tracy wrote:

> Kai Makisara wrote:
> > st does not currently return error for any write problems except when at
> > EOT. The following one-liner fixes the bug (probably mangled by my mail
> > client):
> > 
> > (...)
> >
> > Thanks for the report.
> 
> Thank *you* for the fix!  With disk drive capacities greatly
> outstripping my budgetary ability to buy tape drives that are up to the
> task, I don't know how much longer I'll consider tape to be a viable
> backup option, but I can now hang in there a bit longer :-).

I bought a DVD burner, that seems reasonably cost effective today, and I'm
hoping that hot swap IDE drives will be mature in a year or so. I've
swapped them by turning the whole cable off with hdparm, but it is *not* a
supported operation.

Maybe firewire/USB2.0 drives, the actual drives are reasonably cheap now.

Glad to see the fix, I have 4mm and 8mm tape.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

