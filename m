Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266820AbUGVGsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266820AbUGVGsc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 02:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266821AbUGVGsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 02:48:32 -0400
Received: from c3p0.cc.swin.edu.au ([136.186.1.30]:62736 "EHLO swin.edu.au")
	by vger.kernel.org with ESMTP id S266820AbUGVGsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 02:48:31 -0400
To: "Dale Fountain" <dpf-lkml@fountainbay.com>
Cc: "Andrew Morton" <akpm@osdl.org>, jmorris@redhat.com,
       linux-kernel@vger.kernel.org
From: Tim Connors <tconnors+linuxkernel1090478761@astro.swin.edu.au>
Subject: Re:  [PATCH] Delete cryptoloop
In-reply-to: <4546.24.6.231.172.1090476838.squirrel@24.6.231.172>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>    <20040721230044.20fdc5ec.akpm@osdl.org>    <4411.24.6.231.172.1090470409.squirrel@24.6.231.172>    <20040722014649.309bc26f.akpm@osdl.org> <4546.24.6.231.172.1090476838.squirrel@24.6.231.172>
X-Face: "/6m>=uJ8[yh+S{nuW'%UG"H-:QZ$'XRk^sOJ/XE{d/7^|mGK<-"*e>]JDh/b[aqj)MSsV`X1*pA~Uk8C:el[*2TT]O/eVz!(BQ8fp9aZ&RM=Ym&8@.dGBW}KDT]MtT"<e(`rn*-w$3tF&:%]KHf"{~`X*i]=gqAi,ScRRkbv&U;7Aw4WvC
X-Face-Author: David Bonde mailto:i97_bed@i.kth.se.REMOVE.THIS.TO.REPLY -- If you want to use it please also use this Authorline.
Message-ID: <slrn-0.9.7.4-8073-28820-200407221646-tc@hexane.ssi.swin.edu.au>
Date: Thu, 22 Jul 2004 16:47:28 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Dale Fountain" <dpf-lkml@fountainbay.com> said on Wed, 21 Jul 2004 23:13:58 -0700 (PDT):
> Dm-crypt is still unstable, doesn't have all the features of cryptoloop
> (please see my previous message), yet you wish to dump cryptoloop? At
> least cryptoloop is a known quantity.
> 
> Once dm-crypt can be shown to have all the features of the software it's
> meant to _replace_, I'll be more likely to agree. Otherwise, it sounds
> like this decision is being made on a whim.

*cough* devfs->udev *cough*

I'm such a bastard :)

-- 
TimC -- http://astronomy.swin.edu.au/staff/tconnors/
My code is giving me mixed signals. SIGSEGV then SIGILL then SIGBUS. -- me
