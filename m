Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282182AbRK0R7g>; Tue, 27 Nov 2001 12:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282189AbRK0R70>; Tue, 27 Nov 2001 12:59:26 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:14611 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S282182AbRK0R7R>; Tue, 27 Nov 2001 12:59:17 -0500
Date: Tue, 27 Nov 2001 12:58:48 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200111271758.fARHwmO22631@devserv.devel.redhat.com>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk loglevel cleanup (again)
In-Reply-To: <mailman.1006876204.12313.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1006876204.12313.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus refused wholesale cleanups in the past. Try to identify
worst offenders and start from those, and work through component
maintainers. It's a lot more work, but you have to tough it out.

-- Pete

> When I was making this patch I couldn't resist and fixed
> messed up tabs around affected printks, wrapped some
> lines longer than 80 columns, fixed some typos.
