Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311843AbSCNWo5>; Thu, 14 Mar 2002 17:44:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311844AbSCNWor>; Thu, 14 Mar 2002 17:44:47 -0500
Received: from [206.40.202.198] ([206.40.202.198]:19098 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id <S311843AbSCNWof>; Thu, 14 Mar 2002 17:44:35 -0500
Date: Thu, 14 Mar 2002 14:39:56 -0800 (PST)
From: John Heil <kerndev@sc-software.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "H. Peter Anvin" <hpa@zytor.com>, <linux-kernel@vger.kernel.org>
Subject: Re: IO delay, port 0x80, and BIOS POST codes
In-Reply-To: <E16le8P-00028c-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0203141437450.1286-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Alan Cox wrote:

> Date: Thu, 14 Mar 2002 22:55:45 +0000 (GMT)
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: John Heil <kerndev@sc-software.com>
> Cc: H. Peter Anvin <hpa@zytor.com>, linux-kernel@vger.kernel.org
> Subject: Re: IO delay, port 0x80, and BIOS POST codes
>
> > > It is, in fact, broken on several systems -- I tried ED in SYSLINUX
> > > for a while, and it broke things for people.
> >
> > It does work on many, in fact, we used on a Crusoe based platform
> > as well as the other x86s
> >
> > Let's make it a configurable kernel debug/hacking option else
> > we have the added burden of chasing down a common address.
>
> We've got one. Its 0x80. It works everywhere with only marginal non
> problematic side effects
>

Ok, cool but does that mean you agree or disagree with a configurable
override for those of us in the minority?

Johnh

-
-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------

