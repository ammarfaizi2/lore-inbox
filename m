Return-Path: <linux-kernel-owner+w=401wt.eu-S1755193AbWL3S1s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755193AbWL3S1s (ORCPT <rfc822;w@1wt.eu>);
	Sat, 30 Dec 2006 13:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755191AbWL3S1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Dec 2006 13:27:48 -0500
Received: from p02c11o146.mxlogic.net ([208.65.145.69]:57441 "EHLO
	p02c11o146.mxlogic.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755193AbWL3S1r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Dec 2006 13:27:47 -0500
Date: Sat, 30 Dec 2006 20:27:55 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: =?iso-8859-1?Q?Beno=EEt?= Rouits <brouits@free.fr>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: No sound in KDE with intel hda since 2.6.20-rc1
Message-ID: <20061230182755.GA4225@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <1167501651.14690.10.camel@chimay>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167501651.14690.10.camel@chimay>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 30 Dec 2006 18:29:58.0265 (UTC) FILETIME=[82854690:01C72C40]
X-TM-AS-Product-Ver: SMEX-7.0.0.1526-3.6.1039-14904.000
X-TM-AS-Result: No--5.480500-4.000000-31
X-Spam: [F=0.0100000000; S=0.010(2006120601)]
X-MAIL-FROM: <mst@mellanox.co.il>
X-SOURCE-IP: [194.90.237.34]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> suggestion: change the Amarok audio backend options
>             and test every one until it sounds good.
> 
> reply with re results.
> That will help to understand the problem, if any.

OK.
Under 2.6.19, both alsa and oss backends work.
Under 2.6.20-rc2, oss works but alsa does not.

So I guess the problem is with ALSA interface in my 2.6.20-rc2?


-- 
MST
