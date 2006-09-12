Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWILHJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWILHJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 03:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751387AbWILHJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 03:09:28 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:39659 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751384AbWILHJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 03:09:27 -0400
Date: Tue, 12 Sep 2006 09:08:37 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Randy Dunlap <rdunlap@xenotime.net>
cc: Victor Hugo <victor@vhugo.net>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] e-mail clients
In-Reply-To: <1158031971.5057@shark.he.net>
Message-ID: <Pine.LNX.4.61.0609120906540.6283@yvahk01.tjqt.qr>
References: <1158031971.5057@shark.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>pine (but make sure that it doesn't truncate trailing whitespace)

Truncating whitespace at EOL is a good thing. Otherwise, quilt says

Warning: trailing whitespace in lines 237,364 of 
net/ipv4/netfilter/regexp/regexp.c
Warning: trailing whitespace in line 57 of 
net/ipv4/netfilter/regexp/regsub.c
Warning: trailing whitespace in lines 307,308,309 of 
net/ipv4/netfilter/ipt_layer7.c

for example. Long lines are usually not broken up if pasted verbatim as this example line will show for sure abc.

pine wraps text only when typing (at least that's how I configured
mine), so it is all safe.


Jan Engelhardt
-- 
