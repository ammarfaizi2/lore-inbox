Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268486AbUIWOVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268486AbUIWOVy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 10:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268488AbUIWOVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 10:21:54 -0400
Received: from mail.renesas.com ([202.234.163.13]:40097 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S268486AbUIWOVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 10:21:53 -0400
Date: Thu, 23 Sep 2004 23:21:41 +0900 (JST)
Message-Id: <20040923.232141.579661197.takata.hirokazu@renesas.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: takata@linux-m32r.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.9-rc2-mm2] [m32r] Trivial fix of smc91x.h
From: Hirokazu Takata <takata@linux-m32r.org>
In-Reply-To: <20040923145226.A24734@flint.arm.linux.org.uk>
References: <20040923.224854.582763130.takata.hirokazu@renesas.com>
	<20040923145226.A24734@flint.arm.linux.org.uk>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+lkml@arm.linux.org.uk>
> On Thu, Sep 23, 2004 at 10:48:54PM +0900, Hirokazu Takata wrote:
> > Hello,
> > 
> > Here is a patch to fix smc91x.h for m32r.
> > Please apply.
> 
> Please copy smc91x patches to nico@cam.org.  He looks after this driver
> and needs to review any changes to it.
> 
> Thanks.

I see.

