Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316851AbSFVSpP>; Sat, 22 Jun 2002 14:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316863AbSFVSpO>; Sat, 22 Jun 2002 14:45:14 -0400
Received: from elixir.e.kth.se ([130.237.48.5]:43787 "EHLO elixir.e.kth.se")
	by vger.kernel.org with ESMTP id <S316851AbSFVSpO>;
	Sat, 22 Jun 2002 14:45:14 -0400
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [FREEZE] 2.4.19-pre10 + Promise ATA100 tx2 ver 2.20
References: <3D14C06F.6010906@fabbione.net>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 22 Jun 2002 20:45:14 +0200
In-Reply-To: Fabio Massimo Di Nitto's message of "Sat, 22 Jun 2002 20:22:39 +0200"
Message-ID: <yw1xwusrkv9h.fsf@gladiusit.e.kth.se>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio Massimo Di Nitto <fabbione@fabbione.net> writes:

> Hi all,
>             probably was already discussed (I hope not).
> 
> I get a really bad freeze when there's heavy writing over the 2 x
> 120GB WD disks.
> 
> reading seems to be ok.
> 
> Since Im really not an expert in setting up IDE stuff the only things
> I can say is that
> 
> there's no OOPS or error or nothing on the screen/log.
> 
> The freeze is reproducible both with 2.4.19-pre10 and 2.4.18.
> In my config I have tryed with/without DMA/Promise special options and
> different combinations

Those have no effect in 2.4.19-pre10 and a few earlier pres; I don't
remember the exact number.

> of them with no results.
> 
> I will be glad to offer more info and help if someone can kindly tell
> me how to debug
> 
> this. If it's needed I can consider providing access to the machine.

Does the machine recover from the freeze or do you have to reboot?

-- 
Måns Rullgård
mru@users.sf.net
