Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751160AbWEBTo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbWEBTo5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 15:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWEBTo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 15:44:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:27794 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751160AbWEBTo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 15:44:56 -0400
Date: Tue, 2 May 2006 12:44:45 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Marcel Siegert <mws@linuxtv.org>
cc: David Woodhouse <dwmw2@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, js@linuxtv.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
In-Reply-To: <4457B102.7020802@linuxtv.org>
Message-ID: <Pine.LNX.4.64.0605021242110.4086@g5.osdl.org>
References: <20060430174426.a21b4614.rdunlap@xenotime.net> 
 <1146503166.2885.137.camel@hades.cambridge.redhat.com>  <20060502003755.GA26327@linuxtv.org>
  <1146576495.14059.45.camel@pmac.infradead.org>  <20060502142050.GC27798@linuxtv.org>
  <1146580308.17934.19.camel@pmac.infradead.org>  <20060502101113.17c75a05.rdunlap@xenotime.net>
  <Pine.LNX.4.64.0605021137500.4086@g5.osdl.org> <1146595853.19101.38.camel@pmac.infradead.org>
 <Pine.LNX.4.64.0605021204240.4086@g5.osdl.org> <4457B102.7020802@linuxtv.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 May 2006, Marcel Siegert wrote:
>
> nack. something is a standard or something is not. black or white. grey isn't
> there.

Here's a saying for you:

	"Only stupid people are black or white. The real world isn't".

Anyway, look at the particular document we're talking about. We're talking 
about the kernel standard coding-style.

Within that one, 8-char tabs are standard. Within that one, "u8" is 
standard. Within that one, typedefs are frowned upon.

In other contexts, other things are standard. Live with it.

		Linus
