Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTHTHMc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 03:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbTHTHMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 03:12:32 -0400
Received: from [66.212.224.118] ([66.212.224.118]:18699 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S261757AbTHTHMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 03:12:30 -0400
Date: Wed, 20 Aug 2003 03:12:27 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Kroah-Hartmann <greg@kroah.com>
Subject: Re: Console on USB
In-Reply-To: <Pine.LNX.4.44.0308192200510.886-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.53.0308200310030.7788@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0308192200510.886-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003, Thomas Molina wrote:

> It looks like things are correct, but, as I said, I am unable to get 
> output.  Am I headed for frustration, or is there some advice to get good 
> results?  
> 
> Is there any advice I might be able to use to get this going?  I really 
> want to be able to catch some oops output.

How about forgetting the console= part and just booting and then set the 
console log level so that you're able to get oopses to hit the USB 
console.
