Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbTHaBAV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 21:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbTHaBAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 21:00:21 -0400
Received: from dsl093-172-075.pit1.dsl.speakeasy.net ([66.93.172.75]:43466
	"EHLO marta.kurtwerks.com") by vger.kernel.org with ESMTP
	id S262281AbTHaBAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 21:00:19 -0400
Date: Sat, 30 Aug 2003 20:59:57 -0400
From: Kurt Wall <kwall@kurtwerks.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] check_gcc for i386
Message-ID: <20030831005957.GB263@kurtwerks.com>
References: <Pine.LNX.4.44.0308301957440.20117-100000@logos.cnet> <1062286661.31332.8.camel@dhcp23.swansea.linux.org.uk> <3F5145BB.5080906@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F5145BB.5080906@pobox.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.21-krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoth Jeff Garzik:
>
> Yep.  I introduced check_gcc into 2.4 (backported from 2.5), in fact.
> 
> The above change does exactly what Alan describes, and is a patch I was 
> planning to submit myself :)  I did not want to change compiler options 
> at the time when I submitted the check_gcc patch, but after many months 
> of manually patching to get the best compiler flags, it seems solid.

[nod]

Works fine here with a Pentium II, Pentium III, and an Athlon.

Kurt
-- 
Boy, n.:
	A noise with dirt on it.
