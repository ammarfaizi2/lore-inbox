Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268924AbUH0Ict@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268924AbUH0Ict (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 04:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269260AbUH0Ics
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 04:32:48 -0400
Received: from [139.30.44.16] ([139.30.44.16]:38362 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S268924AbUH0I14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 04:27:56 -0400
Date: Fri, 27 Aug 2004 10:26:46 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: John Hesterberg <jh@sgi.com>
cc: Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@engr.sgi.com>,
       lkml <linux-kernel@vger.kernel.org>, erikj@dbear.engr.sgi.com,
       limin@engr.sgi.com, lse-tech@lists.sourceforge.net,
       Ragnar Kj?rstad <kernel@ragnark.vestdata.no>,
       Yoshitaka ISHIKAWA <y.ishikawa@soft.fujitsu.com>,
       Arthur Corliss <corliss@digitalmages.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: [Lse-tech] Re: [PATCH] new CSA patchset for 2.6.8
In-Reply-To: <20040826184305.GB11393@sgi.com>
Message-ID: <Pine.LNX.4.53.0408271025160.18605@gockel.physik3.uni-rostock.de>
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org>
 <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de>
 <20040826184305.GB11393@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004, John Hesterberg wrote:

> On Thu, Aug 26, 2004 at 07:15:40PM +0200, Tim Schmielau wrote:
> > ...
> > IMHO CSA, ELSA and BSD accounting are too similar to have more than one of 
> > them in the kernel. We should either improve BSD accounting to do the job, 
> > or kill it in favor of a different implementation.
> > 
> > Tim
> 
> We should at least have common data collection in the kernel.
> 
> I could more easily understand different accounting packages on top of
> that that might meet different needs of different classes of users.

Sorry, that is of course what I meant - I am only talking about kernel 
code.

Tim
