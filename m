Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269311AbUH0DDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269311AbUH0DDc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 23:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269380AbUHZSxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 14:53:24 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:22500 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269344AbUHZSqV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 14:46:21 -0400
Date: Thu, 26 Aug 2004 13:43:05 -0500
From: John Hesterberg <jh@sgi.com>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Andrew Morton <akpm@osdl.org>, Jay Lan <jlan@engr.sgi.com>,
       lkml <linux-kernel@vger.kernel.org>, erikj@dbear.engr.sgi.com,
       limin@engr.sgi.com, lse-tech@lists.sourceforge.net,
       Ragnar Kj?rstad <kernel@ragnark.vestdata.no>,
       Yoshitaka ISHIKAWA <y.ishikawa@soft.fujitsu.com>,
       Arthur Corliss <corliss@digitalmages.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Subject: Re: [Lse-tech] Re: [PATCH] new CSA patchset for 2.6.8
Message-ID: <20040826184305.GB11393@sgi.com>
References: <412D2E10.8010406@engr.sgi.com> <20040825221842.72dd83a4.akpm@osdl.org> <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0408261821090.14826@gockel.physik3.uni-rostock.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 07:15:40PM +0200, Tim Schmielau wrote:
> ...
> IMHO CSA, ELSA and BSD accounting are too similar to have more than one of 
> them in the kernel. We should either improve BSD accounting to do the job, 
> or kill it in favor of a different implementation.
> 
> Tim

We should at least have common data collection in the kernel.

I could more easily understand different accounting packages on top of
that that might meet different needs of different classes of users.

John
