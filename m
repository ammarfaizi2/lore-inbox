Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267705AbUJTFIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbUJTFIx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 01:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266143AbUJTFIw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 01:08:52 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:40623 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S269536AbUJTEon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 00:44:43 -0400
Subject: Re: Linux v2.6.9 and GPL Buyout
From: Lee Revell <rlrevell@joe-job.com>
To: Ryan Anderson <ryan@michonline.com>
Cc: "Jeff V. Merkey" <jmerkey@drdos.com>, Dax Kelson <dax@gurulabs.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1098245904.23628.84.camel@krustophenia.net>
References: <Pine.LNX.4.58.0410181540080.2287@ppc970.osdl.org>
	 <417550FB.8020404@drdos.com>
	 <1098218286.8675.82.camel@mentorng.gurulabs.com>
	 <41757478.4090402@drdos.com>  <20041020034524.GD10638@michonline.com>
	 <1098245904.23628.84.camel@krustophenia.net>
Content-Type: text/plain
Message-Id: <1098247307.23628.91.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 20 Oct 2004 00:41:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 00:18, Lee Revell wrote:
> On Tue, 2004-10-19 at 23:45, Ryan Anderson wrote:
> > RCU - originally a paper, implemented in Dynix and in other operating
> > systems from the paper (and patent), implemented in Linux as well.
> 
> You could also make a strong argument that that patent is invalid
> because RCU is obvious.

(replying to myself to avert flames)  OK, after reading the RCU docs, in
all fairness there is a lot more to it than I described, in particular
the database analogy is not quite valid because most of the hard parts
are handled automagically by the DB.  But, my point remains valid, RCU
seems like too general a concept to be patentable, and would probably be
obvious to many people on this list.

Lee


