Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbULKVq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbULKVq2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 16:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262022AbULKVq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 16:46:27 -0500
Received: from adsl-70-241-115-85.dsl.hstntx.swbell.net ([70.241.115.85]:5248
	"EHLO leamonde.no-ip.org") by vger.kernel.org with ESMTP
	id S261658AbULKVq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 16:46:26 -0500
Date: Sat, 11 Dec 2004 15:46:25 -0600
From: "Camilo A. Reyes" <camilo@leamonde.no-ip.org>
To: Sean Neakums <sneakums@zork.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modprobe: QM_MODULES: Funtion not implemented on kernel 2.6.9
Message-ID: <20041211214625.GA2324@leamonde.no-ip.org>
References: <20041211195133.GA2210@leamonde.no-ip.org> <6uvfb8leqg.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6uvfb8leqg.fsf@zork.zork.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2004 at 09:14:15PM +0000, Sean Neakums wrote:
> "Camilo A. Reyes" <camilo@leamonde.no-ip.org> writes:
> 
> > Not sure if this has been raised before, but I get this error message
> > every time I try to load a module, it is not the modprobe program it self
> > causing the problem since I updated it to version 2.4.9 which is the
> > latest out there...
> 
> For Linux 2.6 you will need the module-init-tools package.

Thanks, I was talking 'bout the modutils package, not the mod-init-tools.
