Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbTJIEFI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 00:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbTJIEFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 00:05:08 -0400
Received: from ol.freeshell.org ([192.94.73.20]:6348 "EHLO sdf.lonestar.org")
	by vger.kernel.org with ESMTP id S261841AbTJIEFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 00:05:05 -0400
Date: Thu, 9 Oct 2003 04:04:59 +0000 (UTC)
From: Cherry George Mathew <cherry@sdf.lonestar.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: lkml <linux-kernel@vger.kernel.org>, fastboot@osdl.org
Subject: Re: [Fastboot] kexec update (2.6.0-test7)
In-Reply-To: <20031008172235.70d6b794.rddunlap@osdl.org>
Message-ID: <Pine.NEB.4.58.0310090401310.17767@sdf.lonestar.org>
References: <20031008172235.70d6b794.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Oct 2003, Randy.Dunlap wrote:

> You'll need to update the kexec-syscall.c file for the correct
> kexec syscall number (274).

Is there a consensus about what the syscall number will finally be ? We've
jumped from 256 to 274 over the 2.5.x+  series kernels. Or is it the law
the Jungle ?

--
cherry@sdf.lonestar.org
Homepage - http://cherry.freeshell.org
