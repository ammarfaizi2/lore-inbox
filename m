Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289663AbSA2OqX>; Tue, 29 Jan 2002 09:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289643AbSA2OqN>; Tue, 29 Jan 2002 09:46:13 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:44726 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289680AbSA2OqE>; Tue, 29 Jan 2002 09:46:04 -0500
Date: Tue, 29 Jan 2002 16:40:51 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: fonts corruption with 3dfx drm module
In-Reply-To: <20020129143209.2AE68FB85@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.44.0201291636470.12286-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Dieter [iso-8859-15] Nützel wrote:

> > (mostly because with 3.3.6 i never setup the MTRRs myself)
> 
> We 3.3.6 you have to do it some times.

Yep mine never got enabled per default, if i enabled it i would experience 
the same segfaults and font corruption so i got 3.3.6 to "behave" like 
4.1 default and reproduced the problem.

> This could be all the VIA/mobo/BIOS problems widely discussed.
> Maybe the latest AGP GART issue.

This was about a year ago, and i wasn't aware of an issue.

> Have you ever looked at XFree and/or DRI devel?
> I think this could and should be solved. Without notice nobody cares...

I think i'll do that.

> You should definitely go with XFree86 4.2.0. It is out and most distros have 
> packages available. Then look deeper into the MTRR problem.

Thanks for reply, i'm going to resurrect that board ;)

Cheers,
	Zwane Mwaikambo


