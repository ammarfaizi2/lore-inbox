Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbUCBPGW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 10:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbUCBPGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 10:06:21 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:64388 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S261676AbUCBPFp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 10:05:45 -0500
Date: Tue, 2 Mar 2004 08:05:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Amit S. Kale" <amitkale@emsyssoft.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@suse.cz>, kgdb-bugreport@lists.sourceforge.net
Subject: Re: [KGDB PATCH][1/7] Add / use kernel/Kconfig.kgdb
Message-ID: <20040302150544.GC16434@smtp.west.cox.net>
References: <20040227212301.GC1052@smtp.west.cox.net> <200403021709.26396.amitkale@emsyssoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403021709.26396.amitkale@emsyssoft.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2004 at 05:09:26PM +0530, Amit S. Kale wrote:

> It also makes core.patch dependent on 8250.patch
> Any ideas on fixing that?

No, it's intentional.  eth.patch also depends on 8250.patch.

-- 
Tom Rini
http://gate.crashing.org/~trini/
