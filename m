Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261835AbTCQSu6>; Mon, 17 Mar 2003 13:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261837AbTCQSu6>; Mon, 17 Mar 2003 13:50:58 -0500
Received: from air-2.osdl.org ([65.172.181.6]:26240 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261835AbTCQSuz>;
	Mon, 17 Mar 2003 13:50:55 -0500
Date: Mon, 17 Mar 2003 11:01:36 -0800
From: Bob Miller <rem@osdl.org>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modutils for 2.5
Message-ID: <20030317190136.GB10775@doc.pdx.osdl.net>
References: <Pine.LNX.4.51.0303171931220.29964@dns.toxicfilms.tv> <Pine.LNX.4.51.0303171939040.15852@dns.toxicfilms.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.51.0303171939040.15852@dns.toxicfilms.tv>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 17, 2003 at 07:39:20PM +0100, Maciej Soltysiak wrote:
> Hi,
> 
> is there a special modutils package needed for 2.5 kernels?
> 
> lsmod on 2.5 says QM_MODULES not supported, and while
> 
> # make modules_install
> i always get tons of unresolved symbols about all what is in the modules.
> 
> I tried modutils 2.4.21 and 2.4.23 with the same result
> 
> Regards,
> Maciej Soltysiak
Yes there is.  Look in:

	ftp.kernel.org://pub/linux/kernel/people/rusty/modules

I think the latest version is:

	module-init-tools-0.9.10.tar.bz2
	module-init-tools-0.9.10.tar.bz

Pick whichever compress format makes you happiest.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
