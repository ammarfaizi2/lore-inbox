Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbTINO2K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 10:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbTINO2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 10:28:10 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:4 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261155AbTINO2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 10:28:08 -0400
Date: Sun, 14 Sep 2003 16:28:01 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Nick Piggin <piggin@cyberone.com.au>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: KConfig help text not shown in 2.6.0-test5
In-Reply-To: <3F645F0A.1000104@cyberone.com.au>
Message-ID: <Pine.LNX.4.44.0309141626540.19512-100000@serv>
References: <3F63197D.2000306@cyberone.com.au> <Pine.LNX.4.44.0309131720270.8124-100000@serv>
 <3F645F0A.1000104@cyberone.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 14 Sep 2003, Nick Piggin wrote:

> >BTW you can reach the individual help within 'make config' by appending a 
> >'?' to the number (e.g. '1?').
> 
> What I am seeing is the help text for the whole choice thingy is used as
> the help text for the individual choices. This patch doesn't fix that.
> How is it supposed to work? I assume you tried it and saw what it was
> doing, so am I just mistaken in how I think it should work?

Yes, it works here, what exactly did you try?

bye, Roman

