Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130411AbRBIL0P>; Fri, 9 Feb 2001 06:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130531AbRBIL0F>; Fri, 9 Feb 2001 06:26:05 -0500
Received: from mgw-x3.nokia.com ([131.228.20.26]:18939 "EHLO mgw-x3.nokia.com")
	by vger.kernel.org with ESMTP id <S130411AbRBILZ6>;
	Fri, 9 Feb 2001 06:25:58 -0500
Message-ID: <6D1A8E7871B9D211B3B00008C7490AA5645312@treis03nok>
From: Patrick.Stickler@nokia.com
To: snwahofm@mi.uni-erlangen.de
Cc: linux-kernel@vger.kernel.org
Subject: RE: Kernel panics on C1VN and RH 6.2 or 7.0
Date: Fri, 9 Feb 2001 13:25:56 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2652.78)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
I'll try, though since the system locks up in an unbootable
state and most of the message scrolls off the screen and is
unretrievable, it is difficult.

Patrick

-----Original Message-----
From: ext Walter Hofmann
To: Patrick.Stickler@nokia.com
Sent: 2/9/01 1:22 PM
Subject: Re: Kernel panics on C1VN and RH 6.2 or 7.0



On Fri, 9 Feb 2001 Patrick.Stickler@nokia.com wrote:

> 
> Hi, 
> 
> I'm trying to install RH Linux on my C1VN and am getting
> some strange behavior that doesn't correspond to any of the
> various HOWTO's etc. on putting Linux on the C1VN.
> 
> I'm wondering if the amount of RAM matters (I have 192MB,
> the others all seem to have 128MB) or maybe I have one
> of the broken CPU's.
> 
> No matter whether I try to install 6.2 or 7.0, via CD-ROM
> or network, somewhere during the install (at random places)
> I get a kernel panic with an error message such as:
> 
>    Unable to handle kernel paging request at virtual address ...
> 
> I've also gotten a few Oops: messages.

people could help you if you had actually included the message in
question---with symbols resolved as described in bug reporting file from
the
kernel tree.

Walter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
