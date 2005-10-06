Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbVJFPtq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVJFPtq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 11:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVJFPtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 11:49:46 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:704 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751119AbVJFPtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 11:49:45 -0400
Date: Thu, 6 Oct 2005 08:49:45 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: umesh chandak <chandak_pict@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kgdb with selinux
Message-ID: <20051006154945.GH3478@smtp.west.cox.net>
References: <20051006135749.46607.qmail@web35914.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051006135749.46607.qmail@web35914.mail.mud.yahoo.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 06:57:49AM -0700, umesh chandak wrote:

> hi,
> I have installed a FC3 with selinux enabled .
> I want to use remote kernel debugger (KGDB) .Can we
> use kgdb with selinux.

I don't see why not, esp if you have KGDB compiled into the kernel
rather than modules.

-- 
Tom Rini
http://gate.crashing.org/~trini/
