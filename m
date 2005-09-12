Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932183AbVILUDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932183AbVILUDk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 16:03:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751121AbVILUDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 16:03:39 -0400
Received: from xenotime.net ([66.160.160.81]:46546 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751120AbVILUDj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 16:03:39 -0400
Date: Mon, 12 Sep 2005 13:03:37 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Hugh Dickins <hugh@veritas.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       =?ISO-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@latinsourcetech.com>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: Tainted lsmod output
In-Reply-To: <Pine.LNX.4.61.0509122055520.5255@goblin.wat.veritas.com>
Message-ID: <Pine.LNX.4.50.0509121301380.30198-100000@shark.he.net>
References: <4325C713.6060908@latinsourcetech.com>
 <Pine.LNX.4.50.0509121129470.30198-100000@shark.he.net>
 <Pine.LNX.4.61.0509122039350.5019@goblin.wat.veritas.com>
 <Pine.LNX.4.50.0509121253300.30198-100000@shark.he.net>
 <Pine.LNX.4.61.0509122055520.5255@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Sep 2005, Hugh Dickins wrote:

> On Mon, 12 Sep 2005, Randy.Dunlap wrote:
> > On Mon, 12 Sep 2005, Hugh Dickins wrote:
> > >
> > > The one that puzzles me greatly isn't listed there: 'G'
> >
> > I guess it means GPL.
> >
> > It's just the opposite of 'P', whereas all of the others
> > have opposites of ' '.
>
> I guess the same, but doesn't it seem a strange kind of taint?

<tainted> has already been found to be non-0.
Looks like someone decided to reinforce the GPL-ness of
all modules at that point and that some other tainted flag(s)
should be set.

-- 
~Randy
