Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbUKRQgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbUKRQgI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 11:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUKRQgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 11:36:08 -0500
Received: from modemcable166.48-200-24.mc.videotron.ca ([24.200.48.166]:59108
	"EHLO xanadu.home") by vger.kernel.org with ESMTP id S261865AbUKRQgH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 11:36:07 -0500
Date: Thu, 18 Nov 2004 11:34:56 -0500 (EST)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: David Woodhouse <dwmw2@infradead.org>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [patch] 2.6.10-rc2-mm2: MTD_XIP dependencies
In-Reply-To: <1100793112.8191.7315.camel@hades.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.61.0411181132440.12260@xanadu.home>
References: <20041118021538.5764d58c.akpm@osdl.org>  <20041118154110.GE4943@stusta.de>
 <1100793112.8191.7315.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Nov 2004, David Woodhouse wrote:

> On Thu, 2004-11-18 at 16:41 +0100, Adrian Bunk wrote:
> > Let's put the dependencies from the #error into the Kconfig file:
> 
> Looks sane to me. Nico?

And why is the current arrangement actually a problem?


Nicolas
