Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUGTOdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUGTOdw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 10:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUGTOdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 10:33:51 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:22989 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265900AbUGTOdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 10:33:42 -0400
Date: Tue, 20 Jul 2004 10:36:54 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.7 crash
In-Reply-To: <2E314DE03538984BA5634F12115B3A4E62E8B9@email1.mitretek.org>
Message-ID: <Pine.LNX.4.58.0407201018070.21932@montezuma.fsmlabs.com>
References: <2E314DE03538984BA5634F12115B3A4E62E8B9@email1.mitretek.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2004, Piszcz, Justin Michael wrote:

> After running a session for a long period of time, I was going to
> shutdown my machine, when I went to shutdown:
> Kernel 2.6.7 crashed w/ VMWare 4.5.2.
>
> I could not copy/paste text because it had crashed at the time, so here
> is a screenshot:
> http://installkernel.tripod.com/kernel.png (32KiB)
> Any idea what happened here?

Try and reproduce the oops with a recent kernel (2.6.8-rc2) then log the
entire error by using the vmware serial to file option, then boot the
kernel with console=ttyS0,38400.
