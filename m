Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267906AbTBVU27>; Sat, 22 Feb 2003 15:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267907AbTBVU26>; Sat, 22 Feb 2003 15:28:58 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11395
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267906AbTBVU26>; Sat, 22 Feb 2003 15:28:58 -0500
Subject: Re: 2.4 series IDE troubles
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bill Davidsen <davidsen@tmr.com>
Cc: shoninnaive@sbcglobal.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1030222135641.27473B-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1030222135641.27473B-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045949964.5679.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 22 Feb 2003 21:39:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-02-22 at 19:02, Bill Davidsen wrote:
> On 21 Feb 2003, Alan Cox wrote:
> 
> > > And without that information there is no way to fix it. At a first guess 
> > > > you've stuck an IDE master and a flash slave via an adapter on the same
> > > > cable. 
> > > 
> > > Didn't he say it worked in 2.2? If that's true then perhaps it should in
> > > 2.4 and later.
> > 
> > Did I say otherwise ? But if he isnt using 2.4.21pre-ac then it wont
> 
> Will this not migrate into mainline? Or is there some objection to it?

It should be in mainline very soon. Its one of a set of patches Im waiting for
the next Marcelo release to resynchronize.

