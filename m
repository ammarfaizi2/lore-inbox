Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265298AbUEOAXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbUEOAXu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 20:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264860AbUEOAQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 20:16:33 -0400
Received: from dingo.clsp.jhu.edu ([128.220.117.40]:3200 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S264650AbUENXtd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:49:33 -0400
Date: Fri, 14 May 2004 05:16:25 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ari Pollak <ajp@aripollak.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swsusp + APM in 2.6.6
Message-ID: <20040514031625.GC14773@elf.ucw.cz>
References: <1084411449.2562.20.camel@ansel.lan> <20040513114250.GB16524@cathedrallabs.org> <c7vo3c$hfu$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7vo3c$hfu$1@sea.gmane.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> You should be able to accomplish the same thing with "echo disk > 
> /sys/power/state", as it says in the same file.

Thats *not* the same thing. That involves pmdisk. Different
beast. Different beast you do not want to touch (*).
							Pavel

(*) if you have intel-agp or similar, or highmem.
-- 
When do you have heart between your knees?
