Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWECWGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWECWGj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 18:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWECWGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 18:06:39 -0400
Received: from xenotime.net ([66.160.160.81]:48814 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751373AbWECWGi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 18:06:38 -0400
Date: Wed, 3 May 2006 15:09:02 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, js@linuxtv.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] CodingStyle: add typedefs chapter
Message-Id: <20060503150902.1b0c3543.rdunlap@xenotime.net>
In-Reply-To: <1146693164.20773.62.camel@pmac.infradead.org>
References: <20060430174426.a21b4614.rdunlap@xenotime.net>
	<1146503166.2885.137.camel@hades.cambridge.redhat.com>
	<20060502003755.GA26327@linuxtv.org>
	<1146576495.14059.45.camel@pmac.infradead.org>
	<20060502142050.GC27798@linuxtv.org>
	<1146580308.17934.19.camel@pmac.infradead.org>
	<20060502101113.17c75a05.rdunlap@xenotime.net>
	<Pine.LNX.4.64.0605021137500.4086@g5.osdl.org>
	<1146595853.19101.38.camel@pmac.infradead.org>
	<Pine.LNX.4.64.0605021204240.4086@g5.osdl.org>
	<1146612136.19101.47.camel@pmac.infradead.org>
	<20060503124100.9b50aa12.rdunlap@xenotime.net>
	<1146693164.20773.62.camel@pmac.infradead.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 May 2006 22:52:44 +0100 David Woodhouse wrote:

> On Wed, 2006-05-03 at 12:41 -0700, Randy.Dunlap wrote:
> > All references to "standard types" now say "standard C99 types".
> > However, Linus still objects to the C99 integer typedefs AFAICT.
> > Are we at an impasse?
> > It would be a really Good Idea to have something about typedefs
> > in Doc/CodingStyle. 
> 
> Absolutely, and you need to document the exceptions. That includes
> saying that 'u32' et al are OK.

Uh, I think that it currently says that...

---
~Randy
