Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266920AbUGMWOS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266920AbUGMWOS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 18:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267082AbUGMWOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 18:14:17 -0400
Received: from imap.gmx.net ([213.165.64.20]:12739 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266920AbUGMWOQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 18:14:16 -0400
X-Authenticated: #20450766
Date: Wed, 14 Jul 2004 00:13:10 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Jeff Garzik <jgarzik@pobox.com>
cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [Bug 2905] New: Aironet 340 PCMCIA card not working since 2.6.7
In-Reply-To: <Pine.LNX.4.60.0406232149230.3950@poirot.grange>
Message-ID: <Pine.LNX.4.60.0407131218300.1444@poirot.grange>
References: <200406171753.i5HHrx38015816@fire-2.osdl.org>
 <Pine.LNX.4.60.0406172152310.5847@poirot.grange> <20040623132456.A27549@flint.arm.linux.org.uk>
 <Pine.LNX.4.60.0406232149230.3950@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2004, Guennadi Liakhovetski wrote:

> On Wed, 23 Jun 2004, Russell King wrote:
>
>> On Thu, Jun 17, 2004 at 09:58:32PM +0200, Guennadi Liakhovetski wrote:
>>> Don't think it will help for this specific problem, but this patch fixes
>>> alignment problem (especially seen on ARM, Russell:-)). Sending as a 
>>> text attachment, as my setup is known to mangle tabs...
>>> 
>>> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> 
>> Can you forward this to Jeff Garzik please?
>
> Jeff, please, apply to 2.6. It should also go into 2.4, it is quite trivial 
> and is actually a bugfix. Don't know if it will aply to 2.4, if not, and if 
> you prefer me to do it rather than do it yourself, I could rediff it against 
> 2.4 too.

Jeff

It's not yet in 2.6.7, didn't see it in  2.6.8-rc1 announcement either, 
didn't check the code though. Have I missed it, or is it still not 
applied? Are you considering applying it to a later version?

Thanks
Guennadi
---
Guennadi Liakhovetski

