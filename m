Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261542AbSKCBNG>; Sat, 2 Nov 2002 20:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261554AbSKCBNG>; Sat, 2 Nov 2002 20:13:06 -0500
Received: from w032.z064001165.sjc-ca.dsl.cnc.net ([64.1.165.32]:17735 "EHLO
	nakedeye.aparity.com") by vger.kernel.org with ESMTP
	id <S261542AbSKCBNF>; Sat, 2 Nov 2002 20:13:05 -0500
Date: Sat, 2 Nov 2002 17:24:17 -0800 (PST)
From: "Matt D. Robinson" <yakker@aparity.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Bill Davidsen <davidsen@tmr.com>, Steven King <sxking@qwest.net>,
       Linus Torvalds <torvalds@transmeta.com>,
       Joel Becker <Joel.Becker@oracle.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [lkcd-general] Re: What's left over.
In-Reply-To: <1036250967.16803.18.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0211021122530.28078-100000@nakedeye.aparity.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Nov 2002, Alan Cox wrote:
|>On Sat, 2002-11-02 at 05:17, Bill Davidsen wrote:
|>>   I was hoping Alan would push Redhat to put this in their Linux so we
|>> could resolve some of the ongoing problems which don't write an oops to a
|>> log, but I guess none of the developers has to actually support production
|>> servers and find out why they crash.
|>
|>I think several Red Hat people would disagree very strongly. Red Hat
|>shipped with the kernel symbol decoding oops reporter for a good reason,
|>and also acquired netdump for a good reason. 

It would be great if crash dumping were an option, at the very least
to unify the netdump, oops reporter and disk dumping (for those that
want it) into a single infrastructure.  Long term, that's probably
where this is going anyway.  It takes away the religious "who is right"
argument, which is fundamentally silly.

Maybe one day.  I think quite a few Red Hat customers would
appreciate it.

--Matt

P.S.  IBM shouldn't have signed a contact with Red Hat without
      requiring certain features in Red Hat's OS(es).  Pushing for
      LKCD, kprobes, LTT, etc., wouldn't be on this list for a whole
      variety of cases if that had been done in the first place.

P.S.  As an aside, too many engineers try and make product marketing
      decisions at Red Hat.  I personally think that's really bad for
      their business model as a whole (and I'm not referring to LKCD).

