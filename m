Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265262AbSKFBKm>; Tue, 5 Nov 2002 20:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265263AbSKFBKm>; Tue, 5 Nov 2002 20:10:42 -0500
Received: from [212.18.235.100] ([212.18.235.100]:40713 "EHLO
	tench.street-vision.com") by vger.kernel.org with ESMTP
	id <S265262AbSKFBKl>; Tue, 5 Nov 2002 20:10:41 -0500
Subject: Re: promise ide problem: missing disks
From: Justin Cormack <justin@street-vision.com>
To: Justin Cormack <justin@street-vision.com>
Cc: Brian Jackson <brian-kernel-list@mdrx.com>,
       Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <1036543602.2292.54.camel@lotte>
References: <1036525756.2291.45.camel@lotte>
	<1036539902.2291.48.camel@lotte> 
	<20021106000052.21645.qmail@escalade.vistahp.com> 
	<1036543602.2292.54.camel@lotte>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Nov 2002 01:17:11 +0000
Message-Id: <1036545436.2291.61.camel@lotte>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-06 at 00:46, Justin Cormack wrote:
> On Wed, 2002-11-06 at 00:00, Brian Jackson wrote:
> > I may be able to help you narrow it down a bit. I have used 2.4.19-vanilla 
> > and it worked fine(all drives showed up). When I tried 
> > fnk10(www.cipherfunk.org) the drive on the secondary channel doesn't show 
> > up. I don't know exactly what changes fnk10 has with regards to ide, but I 
> > know he has put a bunch of stuff from the 20-pre series in fnk10. Hope this 
> > helps. 
> 
> Actually my previous mail wasnt accurate - it was the RH 7.3 kernel that
> works not 8.0 - I forgot which distro I had on it. I think it is the
> changes between 2.4.19 to 2.4.20-pre as you suggest (I have to change my
> ethernet card to check this). Its the big ide change from -ac perhaps.
> The diff is very big, so it is hard to narrow down quickly.
> 
> Andre, Alan any idea? does your second channel work?

hmm, well 2.4.19 vanilla doesnt work for me, but RH 7.3 and 8.0 do.
Guess lots of regression tests needed...



