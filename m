Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265353AbUADKZK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 05:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265356AbUADKZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 05:25:09 -0500
Received: from mail.mediaways.net ([193.189.224.113]:664 "HELO
	mail.mediaways.net") by vger.kernel.org with SMTP id S265353AbUADKZF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 05:25:05 -0500
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
From: Soeren Sonnenburg <kernel@nn7.de>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: Lincoln Dale <ltd@cisco.com>, Con Kolivas <kernel@kolivas.org>,
       Willy Tarreau <willy@w.ods.org>, Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>, gillb4@telusplanet.net
In-Reply-To: <3FF7DA24.40802@cyberone.com.au>
References: <200401041242.47410.kernel@kolivas.org>
	 <Pine.LNX.4.44.0401031439060.24942-100000@coffee.psychology.mcmaster.ca>
	 <200401040815.54655.kernel@kolivas.org>
	 <20040103233518.GE3728@alpha.home.local>
	 <200401041242.47410.kernel@kolivas.org>
	 <5.1.0.14.2.20040104195316.02151e98@171.71.163.14>
	 <3FF7DA24.40802@cyberone.com.au>
Content-Type: text/plain
Message-Id: <1073211879.3261.6.camel@localhost>
Mime-Version: 1.0
Date: Sun, 04 Jan 2004 11:24:39 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
> Or, out of interest, an alternate scheduler?
> 
> http://www.kerneltrap.org/~npiggin/w29p2.gz
> (applies 2.6.1-rc1-mm1, please renice X to -10 or so)

Thats nothing *I* can try out as I am on the powerpc benh tree.

Soeren.

