Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271223AbTHHFZY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 01:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271225AbTHHFZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 01:25:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:47007 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271223AbTHHFZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 01:25:23 -0400
Date: Thu, 7 Aug 2003 22:27:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Clements <Paul.Clements@SteelEye.com>
Cc: ldl@aros.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0 NBD driver: remove send/recieve race for request
Message-Id: <20030807222718.5ef37049.akpm@osdl.org>
In-Reply-To: <3F332ED7.712DFE5D@SteelEye.com>
References: <3F2FE078.6020305@aros.net>
	<3F300760.8F703814@SteelEye.com>
	<3F303430.1080908@aros.net>
	<3F30510A.E918924B@SteelEye.com>
	<3F30AF81.4070308@aros.net>
	<3F332ED7.712DFE5D@SteelEye.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Clements <Paul.Clements@SteelEye.com> wrote:
>
> Here's the patch to fix up several race conditions in nbd. It requires
>  reverting the already included (but admittedly incomplete)
>  nbd-race-fix.patch that's in -mm5.
> 
>  Andrew, please apply.

Sure.  Could I please have a summary of what races were fixed, and how?

Thanks.
