Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbULFPE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbULFPE7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 10:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbULFPE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 10:04:59 -0500
Received: from 70-56-133-193.albq.qwest.net ([70.56.133.193]:62179 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261537AbULFPDr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 10:03:47 -0500
Date: Mon, 6 Dec 2004 08:03:14 -0700 (MST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Alexander Nyberg <alexn@dsv.su.se>
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: The bugzilla story
In-Reply-To: <1102342960.727.59.camel@boxen>
Message-ID: <Pine.LNX.4.61.0412060800380.4242@montezuma.fsmlabs.com>
References: <1102342960.727.59.camel@boxen>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2004, Alexander Nyberg wrote:

> I think the alternative trees section should be dropped. This is
> especially a matter for -mm which has most reports of the alternative
> trees in bugzilla. -mm changes way too rapidly to keep track of at
> bugzilla ending up with open bugs that are fixed long ago.
> 
> I also think this goes for any alternative tree, that problems should be
> reported directly to the maintainer/LKML of the tree. Only if a problem
> can be reproduced with the mainline kernel should the bug be reported at
> bugzilla. 

Hi Alexander,
	Yes i agree, -mm has so many bugs fixed and introduced inbetween 
it's short releases that it does often lead to extremely short lived bug 
reports. Thanks for wading through them all.

	Zwane
