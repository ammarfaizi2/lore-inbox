Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWDIWBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWDIWBK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 18:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750938AbWDIWBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 18:01:10 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:48556 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750930AbWDIWBJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 18:01:09 -0400
Date: Mon, 10 Apr 2006 00:01:07 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 5/19] kconfig: improve config load/save output
In-Reply-To: <20060409215637.GE30208@mars.ravnborg.org>
Message-ID: <Pine.LNX.4.64.0604092359000.32445@scrub.home>
References: <Pine.LNX.4.64.0604091727330.23124@scrub.home>
 <20060409213621.GC30208@mars.ravnborg.org> <Pine.LNX.4.64.0604092347460.32445@scrub.home>
 <20060409215637.GE30208@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 9 Apr 2006, Sam Ravnborg wrote:

> > > sym_change_count is only used as a flag, not as a counter.
> > 
> > It was intended as a counter, even it's currently only tested againsted 
> > zero.
> That I figured out myself. But the intention should not be reflected
> years after when the intention did not hold.

There is not much point in changing it right now and it doesn't really 
matter for this patch.

bye, Roman
