Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261760AbVBICdA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261760AbVBICdA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 21:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261756AbVBICcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 21:32:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:58566 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261757AbVBICcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 21:32:17 -0500
Date: Tue, 8 Feb 2005 18:32:12 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: rth@twiddle.net, mingo@elte.hu, linux-kernel@vger.kernel.org,
       manfred@colorfullife.com
Subject: Re: out-of-line x86 "put_user()" implementation
In-Reply-To: <20050208182459.7f5ea4b5.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0502081830160.2165@ppc970.osdl.org>
References: <Pine.LNX.4.58.0502062212450.2165@ppc970.osdl.org>
 <20050207114415.GA22948@elte.hu> <Pine.LNX.4.58.0502071717310.2165@ppc970.osdl.org>
 <20050209012543.GA13802@twiddle.net> <Pine.LNX.4.58.0502081805470.2165@ppc970.osdl.org>
 <20050208182459.7f5ea4b5.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Feb 2005, Andrew Morton wrote:
> 
> I'll take patches from anyone ;)

You'll never live it down. Once you get a name for being easy, you'll
always be known as Andrew "patch-ho" Morton.

		Linus
