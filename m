Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263344AbTHWNGd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 09:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbTHWNGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 09:06:33 -0400
Received: from modemcable009.53-202-24.mtl.mc.videotron.ca ([24.202.53.9]:16256
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263344AbTHWNG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 09:06:29 -0400
Date: Sat, 23 Aug 2003 08:00:23 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Jan De Luyck <lkml@kcore.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Pentium-M?
In-Reply-To: <200308231350.02369.lkml@kcore.org>
Message-ID: <Pine.LNX.4.53.0308230759050.15935@montezuma.fsmlabs.com>
References: <200308231350.02369.lkml@kcore.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Aug 2003, Jan De Luyck wrote:

> Hello List,
> 
> Just a short question. For the Pentium-M as used in the centrino platform, 
> what do I select in the 2.6.0-test4 kernel configuration as the CPU?
> 
> I figure it's not a PIV, but is it a P3? Or is it something special?

For all intents and purposes it's a P4, so select P4.

	Zwane

