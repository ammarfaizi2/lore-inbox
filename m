Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265060AbTLWIV4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 03:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbTLWIV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 03:21:56 -0500
Received: from [193.138.115.2] ([193.138.115.2]:52998 "HELO
	diftmgw.backbone.dif.dk") by vger.kernel.org with SMTP
	id S265060AbTLWIVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 03:21:55 -0500
Date: Tue, 23 Dec 2003 09:19:22 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Stan Bubrouski <stan@ccs.neu.edu>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Badness in pci_find_subsys & sleeping function called from
 invalid context
In-Reply-To: <1072141605.2947.18.camel@duergar>
Message-ID: <Pine.LNX.4.56.0312230916400.28119@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0312221959460.27724@jju_lnx.backbone.dif.dk> 
 <Pine.LNX.4.56.0312222016530.27724@jju_lnx.backbone.dif.dk>
 <1072141605.2947.18.camel@duergar>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Dec 2003, Stan Bubrouski wrote:

> On Mon, 2003-12-22 at 14:18, Jesper Juhl wrote:
> > Forgot to include the "Badness in pci_find_subsys" bits of the log - here
> > you are.
> > Original message below.
>
> Have you tried reporting this to the minion guy(s)? I'm sure if its in
> the open source part of the driver it can be fixed by them.  It's in all
> of our interest (especially us nvidia users *sigh*) to report these
> problems to people who can fix them.
>
I have not reported it there yet, but I'll drop them a line.


/Jesper Juhl

