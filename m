Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310344AbSCKSJC>; Mon, 11 Mar 2002 13:09:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310333AbSCKSIp>; Mon, 11 Mar 2002 13:08:45 -0500
Received: from adsl-209-76-109-63.dsl.snfc21.pacbell.net ([209.76.109.63]:3200
	"EHLO adsl-209-76-109-63.dsl.snfc21.pacbell.net") by vger.kernel.org
	with ESMTP id <S310185AbSCKSHT>; Mon, 11 Mar 2002 13:07:19 -0500
Date: Mon, 11 Mar 2002 10:06:32 -0800
From: Wayne Whitney <whitney@math.berkeley.edu>
Message-Id: <200203111806.g2BI6WL01661@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6 IDE 19
In-Reply-To: <E16kUED-0001GB-00@the-village.bc.nu>
In-Reply-To: <Pine.LNX.4.10.10203110908220.10583-100000@master.linux-ide.org> <E16kUED-0001GB-00@the-village.bc.nu>
Reply-To: whitney@math.berkeley.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In mailing-lists.linux-kernel, you wrote:

> Ok so whats native DFT and where does he (and I for that matter)
> read about it ?

Having recently RMA'ed an IBM drive, I can say that DFT = Drive
Fitness Test, IBM's low-level diagnostics.  And that makes sense in
this context, their DFT software would need taskfile access.

Wayne

