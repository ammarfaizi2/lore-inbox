Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVABWyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVABWyS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jan 2005 17:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVABWyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jan 2005 17:54:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:36528 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261339AbVABWyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jan 2005 17:54:15 -0500
X-Authenticated: #20450766
Date: Sun, 2 Jan 2005 23:53:35 +0100 (CET)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Georg Schild <dangertools@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: cpu throttling powernow-k8 and acpi in kernel
In-Reply-To: <41D80CAB.1060903@gmx.net>
Message-ID: <Pine.LNX.4.60.0501022349340.4725@poirot.grange>
References: <41D80CAB.1060903@gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.60.0501022350281.4725@poirot.grange>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Jan 2005, Georg Schild wrote:

> I have an acer aspire 1501 lmi with amd64 @3000+. i am running a gentoo 64bit
> dist with vanilla 2.6.10 kernel on it.
> 
> i encounter some problems with the speed throttling of the cpu. this kind of

skipped...

Try writing to sensors@stimpy.netroedge.com. I had a CPU-throttling 
problem, when the CPU got throttled down without really getting hot - I 
just had wrongly configured /etc/sensors.conf. Might be your problem too?

HTH
Guennadi
---
Guennadi Liakhovetski
