Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277533AbRKMRgf>; Tue, 13 Nov 2001 12:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277541AbRKMRgY>; Tue, 13 Nov 2001 12:36:24 -0500
Received: from [204.52.186.2] ([204.52.186.2]:25614 "EHLO synx10.smdi.com")
	by vger.kernel.org with ESMTP id <S277533AbRKMRgH>;
	Tue, 13 Nov 2001 12:36:07 -0500
Message-ID: <4BC5D32775F0D311963F0090276DD12E07817A@SYNX10>
From: Giles Tyson <GilesT@smdi.com>
To: "'Jeffrey W. Baker'" <jwbaker@acm.org>,
        Martin Eriksson <nitrax@giron.wox.org>
Cc: linux-kernel@vger.kernel.org
Subject: RE: What Athlon chipset is most stable in Linux?
Date: Tue, 13 Nov 2001 12:29:14 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



-----Original Message-----
From: Jeffrey W. Baker [mailto:jwbaker@acm.org]
>On Tue, 2001-11-13 at 05:19, Martin Eriksson wrote:
>> I'm hearing rumours about my University wanting to set up a cluster with
AMD
>> Athlon XP+DDR computers, so I wonder what chipset is most stable under
>> Linux?
>> 
>> I assume it's the AMD DDR chipset, but I want to be pretty sure.

>I have no problems with the 1400MHz Athlon on AMD 760, including DRI
>using the AGP bridge.

It's my understanding that among boards with the same chipset, some may work
while others do not.  I have tested an Iwill KK266+Raid, with KT133A, and it
would not run with athlon optimizations.  I also have tried an Epox 8KHA+,
with KT266A, and it has been perfectly stable so far, for three days.
