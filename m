Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313982AbSDQAWy>; Tue, 16 Apr 2002 20:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313983AbSDQAWx>; Tue, 16 Apr 2002 20:22:53 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29709 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313982AbSDQAWw>; Tue, 16 Apr 2002 20:22:52 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Why HZ on i386 is 100 ?
Date: 16 Apr 2002 17:22:28 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a9if84$1jp$1@cesium.transmeta.com>
In-Reply-To: <1018964120.13527.37.camel@pc-16.office.scali.no> <E16xTTd-0008Va-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <E16xTTd-0008Va-00@the-village.bc.nu>
By author:    Alan Cox <alan@lxorguk.ukuu.org.uk>
In newsgroup: linux.dev.kernel
>
> > I seem to recall from theory that the 100HZ is human dependent. Any
> > higher and you would begin to notice delays from you input until
> > whatever program you're talking to responds. 
> 
> Ultimately its because Linus pulled that number out of a hat about ten years
> ago. For some workloads 1KHz is much better, for others like giant number
> crunching people actually drop it down to about 5..
> 

Hardly so.  100 Hz was standard on most commercial Unices around the
time the first Linux was done...

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
