Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267259AbSLKSKi>; Wed, 11 Dec 2002 13:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267260AbSLKSKi>; Wed, 11 Dec 2002 13:10:38 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:29056 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S267259AbSLKSKh>;
	Wed, 11 Dec 2002 13:10:37 -0500
Date: Wed, 11 Dec 2002 19:18:04 +0100
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 Changes doc update.
Message-ID: <20021211181804.GA31103@gagarin>
References: <20021211172559.GA8613@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211172559.GA8613@suse.de>
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18MBQq-0001Ex-00*ZM5BCBg2N.A* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2002 at 05:25:59PM +0000, Dave Jones wrote:
> Modules.
> ~~~~~~~~
> - The in-kernel module loader got reimplemented.
> - You need replacement module utilities from
>   http://www.kernel.org/pub/linux/kernel/people/rusty/modules/
> - A backwards compatable set of module utilities is available
>   including v0.7 of the new-style utils in source RPM format from
>   http://www.kernel.org/pub/linux/kernel/people/rusty/modules/modutils-2.4.21-5.src.rpm

Could be worth noting that debian sid contains a "module-init-tools".

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
