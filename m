Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWATLA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWATLA3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 06:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750821AbWATLA3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 06:00:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23238 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750819AbWATLA2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 06:00:28 -0500
Date: Fri, 20 Jan 2006 03:00:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [patch] CONFIG_DOUBLEFAULT Kconfig fix
Message-Id: <20060120030008.5d790c62.akpm@osdl.org>
In-Reply-To: <20060120104722.GJ27079@waste.org>
References: <20060120090159.GA9800@elte.hu>
	<20060120104722.GJ27079@waste.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> On Fri, Jan 20, 2006 at 10:01:59AM +0100, Ingo Molnar wrote:
> > move CONFIG_DOUBLEFAULT from the main Kconfig menu (!) into its proper
> > place: the "Processor Type and features" submenu.
> 
> Hmm. Should have originally shown up under the CONFIG_EMBEDDED menu, I
> guess Andrew moved it.

patch(1) decided to put it somewhere else.  That's happened a few times
with Kconfig files.

