Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317073AbSHLSp5>; Mon, 12 Aug 2002 14:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317278AbSHLSp5>; Mon, 12 Aug 2002 14:45:57 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:54254 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317073AbSHLSp5>; Mon, 12 Aug 2002 14:45:57 -0400
Subject: Re: question about BSD license vs. GPL
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Kendrick M. Smith" <kmsmith@umich.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.4.44.0208121417090.3089-100000@rastan.gpcc.itd.umich.edu>
References: <Pine.SOL.4.44.0208121417090.3089-100000@rastan.gpcc.itd.umich.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 12 Aug 2002 19:47:01 +0100
Message-Id: <1029178021.16421.203.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-12 at 19:33, Kendrick M. Smith wrote:
> the standard BSD license is not).  Can anyone confirm this?  Changing
> the license might be a time-consuming process involving squads of
> University lawyers (ugh!)

According to the FSF it is. There is a concern about patents but I've
been advised (by two people now) that if you are actively submitting the
code then the patent problem doesn't arrive since if you submit it to be
used then sue people you'll lose 8)

So it appears we can indeed (contrary to my original opinion) accept the
code, slap a GPL header on it and stuff it in the kernel. Or for that
matter people may want to contribute changes back under your original
license (if you want to keep an active non GPL tree it may be good to
add a comment and a request for people to do that)

