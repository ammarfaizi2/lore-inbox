Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbUCPW5N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 17:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUCPW5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 17:57:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:35022 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261785AbUCPW5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 17:57:12 -0500
Date: Tue, 16 Mar 2004 14:58:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Corey Minyard <minyard@acm.org>
Cc: bunk@fs.tum.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-mm1: IPMI_SMB still doesn't compile
Message-Id: <20040316145859.224fe3c7.akpm@osdl.org>
In-Reply-To: <4057805A.6060209@acm.org>
References: <20040316015338.39e2c48e.akpm@osdl.org>
	<20040316124035.GN27056@fs.tum.de>
	<4057805A.6060209@acm.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard <minyard@acm.org> wrote:
>
> Ok, let's pull the SMBus driver for now, until we can get the I2C 
> changes in.
> 
> Andrew, do you want a patch?

I guess I'll need one, please.  The current patch I have is everything
bundled together.

