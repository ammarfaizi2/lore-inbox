Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293412AbSBYQ0l>; Mon, 25 Feb 2002 11:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293336AbSBYQ0c>; Mon, 25 Feb 2002 11:26:32 -0500
Received: from air-2.osdl.org ([65.201.151.6]:50194 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S292708AbSBYQ0R>;
	Mon, 25 Feb 2002 11:26:17 -0500
Date: Mon, 25 Feb 2002 08:19:54 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Keith Owens <kaos@ocs.com.au>, Jesse Barnes <jbarnes@sgi.com>,
        David Mosberger <davidm@hpl.hp.com>, Dan Maas <dmaas@dcine.com>,
        <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ben Collins <bcollins@debian.org>
Subject: Re: readl/writel and memory barriers
In-Reply-To: <E16eU6m-0002Ga-00@starship.berlin>
Message-ID: <Pine.LNX.4.33L2.0202250818510.11464-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Feb 2002, Daniel Phillips wrote:

| On February 21, 2002 01:29 am, Randy.Dunlap wrote:
| > On Wed, 20 Feb 2002, Keith Owens wrote:
| > | Ignoring the issue of hardware that reorders I/O, volatile accesses
| > | must not be reordered by the compiler.  From a C9X draft (1999, anybody
| > | have the current C standard online?) :-
| > PDF file, for about US$18 - US$20, downloaded from ISO.
|
| The drafts are supposed to be public.

We probably aren't disagreeing here.
I was writing about a released standard, not a draft.
I thought that's what Keith meant by "current C standard."

-- 
~Randy

