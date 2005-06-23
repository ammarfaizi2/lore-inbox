Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVFWGri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVFWGri (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262558AbVFWGqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:46:14 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:61609 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262367AbVFWGVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:21:37 -0400
To: David Brownell <david-b@pacbell.net>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, kernel@mikebell.org
Subject: Re: [GIT PATCH] Remove devfs from 2.6.12-git
References: <200506222108.50905.david-b@pacbell.net>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Thu, 23 Jun 2005 15:21:26 +0900
In-Reply-To: <200506222108.50905.david-b@pacbell.net> (David Brownell's message of "Wed, 22 Jun 2005 21:08:50 -0700")
Message-Id: <buo4qbpwq3d.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell <david-b@pacbell.net> writes:
> I'd agree that embedded setups are the ones that have been slowest to
> switch over, for various reasons.  One of them is that many LKML folk
> ignore embedded systems issues; "just PC class or better".

I dunno about that -- while maybe the average LKMLer doesn't actively
worry so much about embedded issues, I've found many of them are very
friendly and helpful in getting patches for embedded/small-system
functionality cleaned up and merged into the mainstream kernel.

-miles
-- 
The car has become... an article of dress without which we feel uncertain,
unclad, and incomplete.  [Marshall McLuhan, Understanding Media, 1964]
