Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266175AbTBCIic>; Mon, 3 Feb 2003 03:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266186AbTBCIic>; Mon, 3 Feb 2003 03:38:32 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:7350 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S266175AbTBCIia>; Mon, 3 Feb 2003 03:38:30 -0500
Date: Mon, 3 Feb 2003 09:47:00 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Matti Aarnio <matti.aarnio@zmailer.org>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] use 64 bit jiffies
In-Reply-To: <20030203082800.GT821@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.33.0302030943590.26414-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Feb 2003, Matti Aarnio wrote:

> I do have a number of machines with 100 to 300 day uptimes, all
> with "mere" 32-bit jiffy.  With 1000 Hz clock that means at least
> one full wrap-around of jiffy.

Are these 2.5 machines? If so I'd really like to know whether or not
ps shows old processes as having started in the future.
With a simulated uptime it does, but I might have overlooked something.

Tim

