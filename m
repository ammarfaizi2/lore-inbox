Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289836AbSBKQME>; Mon, 11 Feb 2002 11:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289834AbSBKQLy>; Mon, 11 Feb 2002 11:11:54 -0500
Received: from air-2.osdl.org ([65.201.151.6]:17160 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S289837AbSBKQLo>;
	Mon, 11 Feb 2002 11:11:44 -0500
Date: Mon, 11 Feb 2002 08:07:38 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
cc: Daniel Phillips <phillips@bonn-fries.net>, <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ? 
In-Reply-To: <200202082053.g18Krxja001427@tigger.cs.uni-dortmund.de>
Message-ID: <Pine.LNX.4.33L2.0202110805330.10878-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Feb 2002, Horst von Brand wrote:

| Daniel Phillips <phillips@bonn-fries.net> said:
| > On February 7, 2002 10:41 pm, Mike Touloumtzis wrote:
| > > Adding configuration information to the kernel is a change to the status
| > > quo, and has a cost.  The cost is small, but I'm unsympathetic to that
| > > argument because many small convenience features, each with a small cost,
| > > add up to a large cost.
| >
| > The cost is *zero* if you don't enable the option, is this concept difficult
| > for you?
|
| It isn't zero: Somebody has to add the support, check/fix interactions with
| other features, write documentation, keep the support and its documentation
| up to date when stuff in the kernel changes, userland (and user) has to be
| prepared (and checked that it works if the feature is present, and find
| workarounds if it isn't), ...

There are customers who actually require a decent, reasonable
solution to this problem.  If there is a decent, reasonable
solution, great.  If not, then one will be generated.

| It might be a small cost, but N * small gets big _very_ fast, and the value
| is marginal at best in this case. There are many other such "small cost
| features" with equally small value results that haven't been included. One
| of the big reasons why I like Linux, BTW.

-- 
~Randy

