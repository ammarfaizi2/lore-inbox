Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268135AbUIFPZv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268135AbUIFPZv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 11:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268107AbUIFPZv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 11:25:51 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:28360 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268135AbUIFPZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 11:25:49 -0400
Date: Mon, 6 Sep 2004 11:30:13 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: takata@linux-m32r.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: EXPORT_SYMBOL_NOVERS (was: Re: 2.6.9-rc1-mm3)
In-Reply-To: <Pine.GSO.4.58.0409061539270.17329@waterleaf.sonytel.be>
Message-ID: <Pine.LNX.4.53.0409061129260.14053@montezuma.fsmlabs.com>
References: <20040903014811.6247d47d.akpm@osdl.org> <20040903104239.A3077@infradead.org>
 <Pine.LNX.4.58.0409030814100.4481@montezuma.fsmlabs.com>
 <Pine.LNX.4.58.0409030823530.4481@montezuma.fsmlabs.com>
 <Pine.GSO.4.58.0409061539270.17329@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Sep 2004, Geert Uytterhoeven wrote:

> On Fri, 3 Sep 2004, Zwane Mwaikambo wrote:
> > - arch/m32r/kernel/m32r_ksyms, EXPORT_SYMBOL_NOVERS is deprecated, use
> >   EXPORT_SYMBOL.
> 
> Hint for the kernel janitors? I've just counted +300 of them...

Thats a good idea, could you get it on the janitor todo list?

Thanks,
	Zwane

