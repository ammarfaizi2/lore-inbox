Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751627AbVJSW5o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751627AbVJSW5o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 18:57:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628AbVJSW5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 18:57:44 -0400
Received: from khc.piap.pl ([195.187.100.11]:1796 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751626AbVJSW5n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 18:57:43 -0400
To: Rudolf Polzer <debian-ne@durchnull.de>
Cc: Horms <horms@verge.net.au>, linux-kernel@vger.kernel.org,
       334113@bugs.debian.org, Alastair McKinstry <mckinstry@debian.org>,
       security@kernel.org, team@security.debian.org,
       secure-testing-team@lists.alioth.debian.org
Subject: Re: kernel allows loadkeys to be used by any user, allowing for
 local root compromise
References: <E1EQofT-0001WP-00@master.debian.org>
	<20051018044146.GF23462@verge.net.au>
	<m37jcakhsm.fsf@defiant.localdomain>
	<20051018171645.GA59028%atfield-dt@durchnull.de>
	<m3fyqyhdm8.fsf@defiant.localdomain>
	<20051018204919.GA21286%atfield-dt@durchnull.de>
	<m3oe5l21rr.fsf@defiant.localdomain>
	<20051019132326.GA31526%atfield-dt@durchnull.de>
	<m3y84pjo9m.fsf@defiant.localdomain>
	<20051019202458.GA51688%atfield-dt@durchnull.de>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 20 Oct 2005 00:57:40 +0200
In-Reply-To: <20051019202458.GA51688%atfield-dt@durchnull.de> (Rudolf
 Polzer's message of "Wed, 19 Oct 2005 22:24:58 +0200")
Message-ID: <m3zmp52jyz.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rudolf Polzer <debian-ne@durchnull.de> writes:

> That's the only thing that might actually work - an inductive device wrapped
> around the keyboard cable. But I've never seen those available ready to buy.

There are simpler designs - it's just a serial line, right? A simple
"dongle" can send data from the keyboard to a notebook. With luck two
wires would do (using parallel port for sampling data).

Anyway I wouldn't count on people's reaction when they see someone doing
something unusual.
-- 
Krzysztof Halasa
