Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbTH3IjL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 04:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262945AbTH3IjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 04:39:10 -0400
Received: from dsl-hkigw3g81.dial.inet.fi ([80.222.38.129]:58724 "EHLO
	uworld.dyndns.org") by vger.kernel.org with ESMTP id S263041AbTH3IjJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 04:39:09 -0400
Subject: Re: 2.4.22-jl9: speedstep-centrino.o: init_module: No such device
From: Jussi Laako <jussi.laako@pp.inet.fi>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200308262206.37039.lkml@kcore.org>
References: <200308262206.37039.lkml@kcore.org>
Content-Type: text/plain
Organization: 
Message-Id: <1062232814.1533.0.camel@vaarlahti.uworld>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 Aug 2003 11:40:14 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-26 at 23:06, Jan De Luyck wrote:

> I just patched my 2.4.22 with this patch - so i can get centrino speedstep 
> support in 2.4 - but it won't load:

I just updated cpufreq stuff (along with few other patches) and released
2.4.22-jl12 patch. Not tested much though..

http://www.sonarnerd.net/linux/2.4.22-jl12.patch.bz2


-- 
Jussi Laako <jussi.laako@pp.inet.fi>

