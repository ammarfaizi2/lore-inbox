Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264750AbUGHQ57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbUGHQ57 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 12:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264746AbUGHQ56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 12:57:58 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:57051 "EHLO
	pd3mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S264750AbUGHQ5z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 12:57:55 -0400
Date: Thu, 08 Jul 2004 10:52:17 -0600
From: Travis Morgan <lkml@bigfiber.net>
Subject: Re: SATA problems on two different systems
In-reply-to: <40E3110B.5070503@pobox.com>
To: linux-kernel@vger.kernel.org
Message-id: <1089305536.2524.95.camel@castle.bigfiber.net>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.6
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1088487355.16294.424.camel@castle.bigfiber.net>
 <40E3110B.5070503@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. Sorry about the delayed response. My client didn't thread the
messages correctly and I didn't notice your reply.

I'll try replacing the SATA cables in both machines and see if that
helps. If you need any testing done let me know and I'd be happy to help
out any way I can. Both systems are still having troubles so anything
that might lead to a solution would be a relief. :)

Travis


> You certainly provided the right information, thanks :)
> 
> While I certainly would not rule out a driver bug, these errors are 
> normally indicative of some sort of hardware problem.  My first guess is 
> always to replace the SATA cables.
> 
> I'll be instrumenting the SATA driver to provide a lot more verbosity on 
> error very soon, so getting you to test again when that is in place (a 
> few days, a week at most) would be useful.
> 
> 	Jeff
> 
> 

-- 
Travis Morgan <lkml@bigfiber.net>

