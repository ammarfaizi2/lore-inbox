Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263581AbTIAS2h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 14:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263612AbTIAS2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 14:28:36 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:34480 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S263581AbTIAS2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 14:28:32 -0400
Date: Mon, 1 Sep 2003 20:28:31 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 64 bit jiffies for 2.4.23-pre2
In-Reply-To: <Pine.LNX.4.44.0309011509270.6008-100000@logos.cnet>
Message-ID: <Pine.LNX.4.33.0309012024320.26435-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Sep 2003, Marcelo Tosatti wrote:

> > I think it's the most appropriate solution for 2.4. But you need to decide
> > whether you take this, whether someone should backport the (intrusive and
> > architecture-dependent) 2.6 fix, or whether you drop it completly and let
> > people just upgrade to 2.6.
>
> Sincerely, I prefer people use 2.6.

OK, for people wanting this in their private trees, I'll try to keep an
up-to-date version at

  http://www.physik3.uni-rostock.de/tim/kernel/2.4/


Tim

