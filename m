Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261608AbSJVRYB>; Tue, 22 Oct 2002 13:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbSJVRYA>; Tue, 22 Oct 2002 13:24:00 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:19642 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261608AbSJVRXW>; Tue, 22 Oct 2002 13:23:22 -0400
Subject: Re: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tim Hockin <thockin@sun.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3DB58A47.4020404@sun.com>
References: <200210220036.g9M0aP831358@scl2.sfbay.sun.com>
	<1035280294.31917.19.camel@irongate.swansea.linux.org.uk> 
	<3DB58A47.4020404@sun.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Oct 2002 18:45:40 +0100
Message-Id: <1035308740.31873.107.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 18:26, Tim Hockin wrote:
> Alan Cox wrote:
> > Ok sanity check time. Why do you need qsort and bsearch for this kind of
> > thing. Just how many groups do you plan to support ?
> 
> Unlimited - we've tested with tens of thousands.

Now how about the real world requirements ?

