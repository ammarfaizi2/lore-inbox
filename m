Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262507AbTHZDQq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 23:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbTHZDQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 23:16:45 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:42760
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262507AbTHZDQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 23:16:44 -0400
Date: Mon, 25 Aug 2003 20:16:42 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Nick Piggin <piggin@cyberone.com.au>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Nick's scheduler policy
Message-ID: <20030826031642.GC16831@matchmail.com>
Mail-Followup-To: Nick Piggin <piggin@cyberone.com.au>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
References: <3F48B12F.4070001@cyberone.com.au> <34251.4.4.25.4.1061782057.squirrel@www.osdl.org> <3F498439.60102@cyberone.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F498439.60102@cyberone.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 01:36:25PM +1000, Nick Piggin wrote:
> 
> 
> Randy.Dunlap wrote:
> >Has anyone developed a (run-time) scheduler [policy] selector, via
> >sysctl or sysfs, so that different kernel builds aren't required?
> >
> >I know that I have heard discussions of this previously.
> >
> 
> Not that I know of. This would probably require an extra layer of
...
> In fact this might end up being incompatible with architectures
> like SPARC... but I'm sure someone could make it work if they really
> wanted to.
> 

Why wouldn't it work on sparc?
