Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316857AbSGBTAF>; Tue, 2 Jul 2002 15:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSGBTAE>; Tue, 2 Jul 2002 15:00:04 -0400
Received: from e.kth.se ([130.237.48.5]:18692 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S316857AbSGBTAD>;
	Tue, 2 Jul 2002 15:00:03 -0400
To: ruschein@mail-infomine.ucr.edu (Johannes Ruscheinski)
Cc: M?ns Rullg?rd <mru@users.sourceforge.net>,
       "Mohamed Ghouse , Gurgaon" <MohamedG@ggn.hcltech.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Diff b/w 32bit & 64-bit
References: <5F0021EEA434D511BE7300D0B7B6AB5303C78735@mail2.ggn.hcltech.com>
	<yw1xpty71bea.fsf@gladiusit.e.kth.se>
	<20020701214507.GA21541@mail-infomine.ucr.edu>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 02 Jul 2002 21:02:04 +0200
In-Reply-To: ruschein@mail-infomine.ucr.edu's message of "Mon, 1 Jul 2002 14:45:07 -0700"
Message-ID: <yw1x65zyar83.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ruschein@mail-infomine.ucr.edu (Johannes Ruscheinski) writes:

> Also sprach M?ns Rullg?rd:
> > "Mohamed Ghouse , Gurgaon" <MohamedG@ggn.hcltech.com> writes:
> > 
> > > Hello All
> > >  I am working on a Driver.
> > > Considering the processor 2 B Intel's x86, 
> > > can some one enlighten me with the differences of Linux on a 64-bit
> > > processor & a 32-Bit processor.
> > 
> > For Alpha: sizeof(int) == 4, sizeof(long) == 8, sizeof(void *) == 8
> > For intel: sizeof(int) == 4, sizeof(long) == 4, sizeof(void *) == 8
>                                                   ^^^^^^^^^^^^^^^^^^^
> I don't know where you come up with that.  On x86 Linux the size of
> any pointer is 4 bytes!

Of course it's 4, that's the point. My mistake, sorry if I confused
anyone.

-- 
Måns Rullgård
mru@users.sf.net
