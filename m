Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267613AbTBURtm>; Fri, 21 Feb 2003 12:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267615AbTBURtm>; Fri, 21 Feb 2003 12:49:42 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11136
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267613AbTBURtl>; Fri, 21 Feb 2003 12:49:41 -0500
Subject: Re: 2.4 series IDE troubles
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: shoninnaive@sbcglobal.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1030221115043.22132K-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1030221115043.22132K-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045853980.1196.1.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 21 Feb 2003 18:59:40 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And without that information there is no way to fix it. At a first guess 
> > you've stuck an IDE master and a flash slave via an adapter on the same
> > cable. 
> 
> Didn't he say it worked in 2.2? If that's true then perhaps it should in
> 2.4 and later.

Did I say otherwise ? But if he isnt using 2.4.21pre-ac then it wont


> I've given up a bought a USB flash adaptor, my ISA bus PCMCIA adaptor
> hasn't worked for flash since about 2.4.16 or so. Not a complaint, but
> there may be issues in that support, I just didn't have time to fight with
> the problem.

With 2.4.21pre (the firs 2.4 IDE I hacked on seriously) pcmcia flash works on
my test setups, and gets used fairly hard for digital cameras
