Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268218AbUHXTTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268218AbUHXTTE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 15:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268219AbUHXTTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 15:19:04 -0400
Received: from waste.org ([209.173.204.2]:44004 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S268218AbUHXTTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 15:19:00 -0400
Date: Tue, 24 Aug 2004 14:18:53 -0500
From: Matt Mackall <mpm@selenic.com>
To: Jani Averbach <jaa@jaa.iki.fi>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.x: Kernel Oops with netconsole + serial console
Message-ID: <20040824191853.GF5414@waste.org>
References: <20040819171918.GC5050@jaa.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040819171918.GC5050@jaa.iki.fi>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 11:19:18AM -0600, Jani Averbach wrote:
> [please Cc: me]

And please cc: me, I almost didn't notice this.
> 
> Hi,
> 
> I have tried to setup both netconsole and serial console for
> unattended server (I need a serial console for booting and a netconsole for
> logging).
> 
> However, 2.6.6 and 2.6.8.1 both will oops if both consoles are
> configured and in use. Disabling one of them will help, and system
> boots up normally.

Does it work with netconsole and no serial then? Hmm.

> This is dual amd64, with two BCM5704 NIC.

Can you send your boot dmesg?

-- 
Mathematics is the supreme nostalgia of our time.
