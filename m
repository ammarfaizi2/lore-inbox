Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbVKOAcG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVKOAcG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:32:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbVKOAcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:32:06 -0500
Received: from xenotime.net ([66.160.160.81]:27322 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932213AbVKOAcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:32:04 -0500
Date: Mon, 14 Nov 2005 16:32:03 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Kalin KOZHUHAROV <kalin@thinrope.net>
cc: linux-kernel@vger.kernel.org,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Re: [RFC] HOWTO do Linux kernel development
In-Reply-To: <4379295B.1020601@thinrope.net>
Message-ID: <Pine.LNX.4.58.0511141630050.8548@shark.he.net>
References: <20051114220709.GA5234@kroah.com> <20051114221005.GA5539@kroah.com>
 <4379295B.1020601@thinrope.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2005, Kalin KOZHUHAROV wrote:

> Greg KH wrote:
> > On Mon, Nov 14, 2005 at 02:07:09PM -0800, Greg KH wrote:
> >
> >>So, I've been working on a document for the past week or so to help
> >>alleviate a lot of these problems.
> >
> >
> > Oh, the latest version can be found at:
> > 	http://www.kernel.org/git/?p=linux/kernel/git/gregkh/patches.git;a=blob;f=HOWTO
> > as I'm keeping it in my git patch tree.
>
> As far as the development proces is in TODO state, what about adding Paolo Ciarrocchi's (CCed) doc
> there?
> 	http://linux.tar.bz/articles/2.6-development_process
>
> NB: I just host the artice (with Paolo's permission), and actualy from a few hours ago :-)
>
> Kalin.

As good as that article is, it only mentions "review" for
-stable patches -- nothing about how new functionality or
other fixes are reviewed and added to Linux, which is a
big oversight IMO... although not at all easy to write/describe.

-- 
~Randy
