Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261950AbSI3H3f>; Mon, 30 Sep 2002 03:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261956AbSI3H3e>; Mon, 30 Sep 2002 03:29:34 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:60846 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S261950AbSI3H3e>; Mon, 30 Sep 2002 03:29:34 -0400
Date: Mon, 30 Sep 2002 09:34:46 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Robert Love <rml@tech9.net>, John Levon <levon@movementarian.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] break out task_struct from sched.h
In-Reply-To: <20020929221725.GA7557@suse.de>
Message-ID: <Pine.LNX.4.33.0209300927110.10510-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002, Dave Jones wrote:
> On Sun, Sep 29, 2002 at 05:06:29PM -0400, Robert Love wrote:
>  > > Killing ~600 #include <linux/sched.h> lines however seemed enough for a 
>  > > first round, so I left this for later iterations.
>  > Indeed, good job.
> 
> Seconded. Worth noting that Tim first did this months ago,
> and has been keeping this up to date since.

Well, main reason why it's not yet in mainline months after the first 
iteration is that I don't have more time for kernel hacking.
I've already exceeded my spare time budget, so

anyone on lkml beat me doing a tasks.h before next weekend?

Tim

