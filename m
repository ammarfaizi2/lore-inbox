Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271032AbTGPK5Q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 06:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271031AbTGPK5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 06:57:15 -0400
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:43154 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id S271029AbTGPK5L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 06:57:11 -0400
Date: Wed, 16 Jul 2003 13:11:57 +0200
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org
Subject: Re: IPv6 warnings
Message-ID: <20030716111157.GB15241@h55p111.delphi.afb.lu.se>
References: <20030716113657.A24009@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716113657.A24009@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *19ckCT-0006Dh-00*f06tZHJE0ug*0x63.nu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 11:36:57AM +0100, Russell King wrote:
> Linux version 2.6.0-test1 (src@tika) (gcc version 3.2.2 20030313
>  (Red Hat Linux 3.2.2-10_rmk1)) #1280 Wed Jul 16 11:07:22 BST 2003
> CPU: StrongARM-1110 [6901b118] revision 8 (ARMv4)
> 
> I'm running IPv6 the above, and I'm seeing the following messages.
> ipv6 was built as a module.  Should I be worried?
> 
> IPv6 v0.8 for NET4.0
> IPv6 over IPv4 tunneling driver
> Destroying alive neighbour c18c2a44

Just a "seeing the same here". On i386, ipv6 built in, gcc 3.3

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
