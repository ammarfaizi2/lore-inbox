Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261828AbTHTHPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 03:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbTHTHPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 03:15:52 -0400
Received: from [66.212.224.118] ([66.212.224.118]:19723 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S261828AbTHTHPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 03:15:50 -0400
Date: Wed, 20 Aug 2003 03:15:47 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: zaitcev@redhat.com, tmolina@cablespeed.com, linux-kernel@vger.kernel.org
Subject: Re: Console on USB
In-Reply-To: <32801.4.4.25.4.1061355525.squirrel@www.osdl.org>
Message-ID: <Pine.LNX.4.53.0308200313500.7788@montezuma.mastecende.com>
References: <mailman.1061346549.9440.linux-kernel2news@redhat.com>       
 <200308200446.h7K4kW211793@devserv.devel.redhat.com>
 <32801.4.4.25.4.1061355525.squirrel@www.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003, Randy.Dunlap wrote:

> > You will have a better chance using Ingo's netconsole, if a patch
> > for your Ethernet driver exists.
> 
> Certainly, I agree.

I think Matt Mackall has an updated patch which looks frightfully easy to 
add device support to, i think he may have even made it generic (he 
basically just calls netdriver isrs)
