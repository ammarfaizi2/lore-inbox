Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293309AbSBYD4h>; Sun, 24 Feb 2002 22:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293310AbSBYD42>; Sun, 24 Feb 2002 22:56:28 -0500
Received: from dsl-213-023-043-166.arcor-ip.net ([213.23.43.166]:20372 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S293309AbSBYD4S>;
	Sun, 24 Feb 2002 22:56:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "Randy.Dunlap" <rddunlap@osdl.org>, Keith Owens <kaos@ocs.com.au>
Subject: Re: readl/writel and memory barriers
Date: Sat, 23 Feb 2002 05:48:26 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Jesse Barnes <jbarnes@sgi.com>, David Mosberger <davidm@hpl.hp.com>,
        Dan Maas <dmaas@dcine.com>, <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ben Collins <bcollins@debian.org>
In-Reply-To: <Pine.LNX.4.33L2.0202201627270.3312-100000@dragon.pdx.osdl.net>
In-Reply-To: <Pine.LNX.4.33L2.0202201627270.3312-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16eU6m-0002Ga-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 21, 2002 01:29 am, Randy.Dunlap wrote:
> On Wed, 20 Feb 2002, Keith Owens wrote:
> | Ignoring the issue of hardware that reorders I/O, volatile accesses
> | must not be reordered by the compiler.  From a C9X draft (1999, anybody
> | have the current C standard online?) :-
> PDF file, for about US$18 - US$20, downloaded from ISO.

The drafts are supposed to be public.

-- 
Daniel
