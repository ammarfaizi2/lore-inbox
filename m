Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264169AbTCXMGO>; Mon, 24 Mar 2003 07:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264173AbTCXMGO>; Mon, 24 Mar 2003 07:06:14 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:24765 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264169AbTCXMGN>; Mon, 24 Mar 2003 07:06:13 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200303241217.h2OCHGV22203@devserv.devel.redhat.com>
Subject: Re: Ptrace hole / Linux 2.2.25
To: andrea@suse.de (Andrea Arcangeli)
Date: Mon, 24 Mar 2003 07:17:16 -0500 (EST)
Cc: alan@redhat.com (Alan Cox), mbligh@aracnet.com (Martin J. Bligh),
       jgarzik@pobox.com (Jeff Garzik), jbourne@mtroyal.ab.ca (James Bourne),
       linux-kernel@vger.kernel.org, rml@tech9.net (Robert Love),
       mj@ucw.cz (Martin Mares), skraw@ithnet.com (Stephan von Krawczynski),
       szepe@pinerecords.com, arjanv@redhat.com, pavel@ucw.cz (Pavel Machek)
In-Reply-To: <20030324033505.GJ1449@x30.local> from "Andrea Arcangeli" at Mar 23, 2003 10:35:05 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> nothing I would call major or very significant. Maybe if you merge them,
> then Marcelo will merge them too?  most of them are easily mergeable by
> just checking my ftp area, most start with 05_vm_ and they shouldn't be
> very controversial. Andrew blessed them too, when he splitted them (he
> only giveup on the "-rest" patch so that one is still very monolithic
> sorry ;).

I'm wary of mixing them with IDE but I will take a look. In the 2.2 case
it certainly worked out well
