Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282467AbRKZUWm>; Mon, 26 Nov 2001 15:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282481AbRKZUWc>; Mon, 26 Nov 2001 15:22:32 -0500
Received: from schwerin.p4.net ([195.98.200.5]:38170 "EHLO schwerin.p4.net")
	by vger.kernel.org with ESMTP id <S282467AbRKZUWX>;
	Mon, 26 Nov 2001 15:22:23 -0500
Message-ID: <3C02A4D8.5010405@p4all.de>
Date: Mon, 26 Nov 2001 21:23:52 +0100
From: Michael Dunsky <michael.dunsky@p4all.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: de, en
MIME-Version: 1.0
To: "Elgar, Jeremy" <JElgar@ndsuk.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Mixing Patches: pre-emptive + xfs
In-Reply-To: <F128989C2E99D4119C110002A507409801C53035@topper.hrow.ndsuk.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Elgar, Jeremy wrote:

> Hello
> Just wondering if anyone has try using these two patches together (or is
> this a really bad idea)
> 
> I'm thinking of adding the pre-emptive patch to my laptop and desk top.
> 
> Cheers
> 
> Jeremy
> 
> (BTW both are 2.4.14)


Well - it works.

I have both patches runnig here (installed the xfs-patches and after 
that the preempt-2.4.14-2 - only 2 or 3 minor offsets while patching).
System "feels" fluid now - but my UT crashes hard while using that 
kernel :( Seems it doesn't like it. But while normal work no problems 
detected until now...

ciao

Michael





