Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318353AbSHKUYF>; Sun, 11 Aug 2002 16:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318355AbSHKUYF>; Sun, 11 Aug 2002 16:24:05 -0400
Received: from elixir.e.kth.se ([130.237.48.5]:21521 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S318353AbSHKUYE>;
	Sun, 11 Aug 2002 16:24:04 -0400
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org, debian-alpha@lists.debian.org
Subject: Re: 2.4.19 eat my disc (contents)
References: <20020811175252.GB755@gallifrey>
	<20020811182832.GA21639@wurtel.net> <20020811184356.GC755@gallifrey>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 11 Aug 2002 22:27:18 +0200
In-Reply-To: "Dr. David Alan Gilbert"'s message of "Sun, 11 Aug 2002 19:43:56 +0100"
Message-ID: <yw1xk7mxf8ex.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dr. David Alan Gilbert" <gilbertd@treblig.org> writes:

> > My alpha's been running 2.4.19-rc2 for more than 3 weeks now without any
> > problems (the kernel also has my patches against unaligned accesses in
> > the kernel, for the packet filter and for netfilter).  I don't think
> > anything big would have been changed between rc2 and the final release,
> > so unless it's specific to the IDE driver (I use SCSI) I doubt the
> > kernel is the culprit.
> 
> I suspect the IDE driver; but that is difficult to tell.

I've run 2.4.19-pre8 and up on a 164SX.  No problems there with ide on
promise 20268 or onboard cypress.

-- 
Måns Rullgård
mru@users.sf.net
