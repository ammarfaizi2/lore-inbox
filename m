Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUEUULr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUEUULr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 16:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbUEUULr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 16:11:47 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:43511 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265971AbUEUULq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 16:11:46 -0400
Date: Fri, 21 May 2004 16:12:39 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: FabF <Fabian.Frederick@skynet.be>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.6-mm4] ring_info spinlock initialization
In-Reply-To: <1085167134.7954.3.camel@bluerhyme.real3>
Message-ID: <Pine.LNX.4.58.0405211611580.2864@montezuma.fsmlabs.com>
References: <1085167134.7954.3.camel@bluerhyme.real3>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2004, FabF wrote:

> Hi,
> 	ring_info spinlock was not initialized in INIT_KIOCTX.

Shouldn't something have caught that?

	Zwane

