Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268609AbUHaWyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268609AbUHaWyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 18:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267993AbUHaWw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 18:52:58 -0400
Received: from rproxy.gmail.com ([64.233.170.197]:13952 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268443AbUHaWtr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 18:49:47 -0400
Message-ID: <f1af5b0e040831154953d92a2c@mail.gmail.com>
Date: Tue, 31 Aug 2004 15:49:47 -0700
From: Jeremy Brand <jbrand@gmail.com>
Reply-To: Jeremy Brand <jbrand@gmail.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: CONFIG_MAGIC_SYSRQ on i386 unavailable?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040831145340.2d206ae6.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <f1af5b0e040831132550af6758@mail.gmail.com> <20040831145340.2d206ae6.rddunlap@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2004 14:53:40 -0700, Randy.Dunlap <rddunlap@osdl.org> wrote:
> On Tue, 31 Aug 2004 13:25:19 -0700 Jeremy Brand wrote:
> 
> | Hi all,
> |
> | In the latest 2.4 and 2.6 kernels, Documentation/sysrq.txt seems to
> | still mention that MAGIC SYSRQ is still available, however I can not
> | find it in the configuration.  When I add CONFIG_MAGIC_SYSRQ to
> | .config and run oldconfig, it vanishes.
> 
> You didn't say what architecture, and the answer may vary by arch.,
> especially in 2.4.x.

Hi, Sorry, I did say the arch, but only in the subject.

i386.

> In 2.4.27, you have to enable 'Kernel debugging' in the
> 'Kernel hacking' menu in order to be able to set MAGIC_SYSRQ.
> (for i386 arch.)
> 
> In 2.6.9-rc1, you have to enable 'Kernel debugging' in the
> 'Kernel hacking' menu in order to be able set MAGIC_SYSRQ.
> 
> What arch. specifically?
> 
> | What is the prefered method of enabling magic sysrq on i386?  That was
> | a really nice feature.  I hope it has not been removed.

Thanks.

That's probably enough info anyway (re: kernel debug).

Sincerely,
Jeremy
