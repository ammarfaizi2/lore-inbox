Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266012AbTFWNK3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 09:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbTFWNK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 09:10:29 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:52472 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S266012AbTFWMvt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 08:51:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <jesse@cats-chateau.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [OT] Re: Troll Tech [was Re: Sco vs. IBM]
Date: Mon, 23 Jun 2003 08:05:29 -0500
X-Mailer: KMail [version 1.2]
Cc: "Henning P. " Schmiedehausen <hps@intermeta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <063301c32c47$ddc792d0$3f00a8c0@witbe> <03062307163100.31982@tabby> <1056372257.13528.31.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1056372257.13528.31.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Message-Id: <03062308052903.31982@tabby>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 June 2003 07:44, Alan Cox wrote:
> On Llu, 2003-06-23 at 13:16, Jesse Pollard wrote:
> > And IA32 applications run on IA64 without recompiling????
>
> Yes
>
> > Or worse, a 286 app runs on IA64...
>
> Yes
>
> > How about a 186...
>
> Yes
>
> Although at a certain point you can switch to software emulation because
> you'll trivially outperform the "real" hardware.

It would almost have to be emulation.. I haven't seen a system that supports
segmentation in user mode in quite a while.

>
> Also you'll notice one of the big wins about AMD x86-64 is running
> x86-32 apps well.

news to my AIDA compiler... (though that may be due to DOS no longer working
on anything recent.. BTW.. it is the old z compiler thing that only supported 
16bit addressing with segmentation.. I'm dropping that turd and only keeping
the language reference after my relocation completes.. and the 286 is going 
in the spare parts bin).

Though I did know AMD supported the IA32, I didn't think the Itanium supported
that old an instruction set as the 186 segmentation support.
