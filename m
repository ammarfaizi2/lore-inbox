Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267540AbUHaVBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267540AbUHaVBs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 17:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268875AbUHaUeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 16:34:13 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:37780 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267538AbUHaUZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 16:25:22 -0400
Message-ID: <f1af5b0e040831132550af6758@mail.gmail.com>
Date: Tue, 31 Aug 2004 13:25:19 -0700
From: Jeremy Brand <jbrand@gmail.com>
Reply-To: Jeremy Brand <jbrand@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: CONFIG_MAGIC_SYSRQ on i386 unavailable?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

In the latest 2.4 and 2.6 kernels, Documentation/sysrq.txt seems to
still mention that MAGIC SYSRQ is still available, however I can not
find it in the configuration.  When I add CONFIG_MAGIC_SYSRQ to
.config and run oldconfig, it vanishes.

What is the prefered method of enabling magic sysrq on i386?  That was
a really nice feature.  I hope it has not been removed.

Thanks,
Jeremy
