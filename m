Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266278AbTAUIFr>; Tue, 21 Jan 2003 03:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266320AbTAUIFq>; Tue, 21 Jan 2003 03:05:46 -0500
Received: from dhcp34.trinity.linux.conf.au ([130.95.169.34]:22912 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S266278AbTAUIFq>; Tue, 21 Jan 2003 03:05:46 -0500
Subject: RE: VIA C3 and random SIGTRAP or segfault
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Larry Sendlosky <Larry.Sendlosky@storigen.com>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Miklos Szeredi <Miklos.Szeredi@eth.ericsson.se>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <7BFCE5F1EF28D64198522688F5449D5AC63352@xchangeserver2.storigen.com>
References: <7BFCE5F1EF28D64198522688F5449D5AC63352@xchangeserver2.storigen.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043047801.12094.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 20 Jan 2003 07:30:02 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-15 at 14:15, Larry Sendlosky wrote:
> We're seeing the same thing on a mini-ITX based system.
> init is segfaulting :(( .  We've never seen this on our
> other non-C3 systems running the same codebase. We've instrumented
> the kernel to help catch the initial problem, hopefully it will
> trigger soon.

I run Red Hat 8.x on both EPIA and EPIA-M boards without problems. 
I have seen weird crashes on EPIA boards with marginal RAM (you
need the right cas for EPIA otherwise it will die under any kind
of bus mastering)

