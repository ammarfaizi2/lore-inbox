Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129351AbQKHH1u>; Wed, 8 Nov 2000 02:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129270AbQKHH1l>; Wed, 8 Nov 2000 02:27:41 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:41223 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129144AbQKHH1b>; Wed, 8 Nov 2000 02:27:31 -0500
Date: Tue, 7 Nov 2000 23:26:34 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
cc: jt@hpl.hp.com, Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Dag Brattli <dagb@fast.no>
Subject: Re: [RANT] Linux-IrDA status
In-Reply-To: <3A08DFCF.49845763@holly-springs.nc.us>
Message-ID: <Pine.LNX.4.10.10011072316180.15590-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Nov 2000, Michael Rothwell wrote:
> 
> Like what? I'm not sure what you're saying here. It seems that the pople
> writing the IrDA code have gotten no feedback from you as to why their
> patch is never accepted -- could you clarify?

Just to clarify.

The ONLY message from the IrDA people I've gotten during the last few
weeks has been a SINGLE email from Dag Brattli, with a 330kB patch.

The whole, full, unabridged explanation for those 330kB of patches:

>> Hello Linus,
>> 
>> Here is the latest IrDA patch for Linux-2.4.0-test10. 
>> 
>> Short summary: 
>> 
>> o Fixes IrDA in 2.4
>> o Touches _no_ other files. 
>> 
>> Please apply! 
>> 
>> Best regards
>> 
>> Dag Brattli

That's it.

ONE message during the last month. ONE huge patch. From people who should
have known about 2.4.x being pending for some time. 

10,000+ lines of diff, with _no_ effort to split it up, or explain it with
anything but

	"o Fixes IrDA in 2.4"

and these people expect me to reply, sending long explanations of why I
don't like them? After they did nothing of the sort for the code they
claim should have been applied? Nada.

Get a grip. 

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
