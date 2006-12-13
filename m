Return-Path: <linux-kernel-owner+w=401wt.eu-S965004AbWLMPcv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965004AbWLMPcv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 10:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965002AbWLMPcv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 10:32:51 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:3079 "EHLO ore.jhcloos.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965004AbWLMPcu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 10:32:50 -0500
From: James Cloos <cloos@jhcloos.com>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: drivers/video/aty/radeon_backlight.c
In-Reply-To: <20061213142930.GA12686@hansmi.ch> (Michael Hanselmann's message
	of "Wed\, 13 Dec 2006 15\:29\:30 +0100")
References: <m3irgflxh4.fsf@lugabout.jhcloos.org>
	<20061213142930.GA12686@hansmi.ch>
Copyright: Copyright 2006 James Cloos
X-Hashcash: 1:23:061213:linux-kernel@hansmi.ch::sgbECuL/uwMkZi7e:0000000000000000000000000000000000000004YJP
X-Hashcash: 1:23:061213:linux-kernel@vger.kernel.org::E3rIQ743VOoJWYHC:000000000000000000000000000000000HmJK
X-Hashcash: 1:23:061213:linux-fbdev-devel@lists.sourceforge.net::7MeBFrn893SZsW+C:0000000000000000000001IxD6
Date: Wed, 13 Dec 2006 10:32:13 -0500
Message-ID: <m3d56nlskr.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/23.0.0 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Michael" == Michael Hanselmann <linux-kernel@hansmi.ch> writes:

JimC> Are there any dependencies in $subject which would preclude
JimC> changing drivers/video/Kconfig ....

Michael> Yes.

Ok. Thanks.

JimC> is radeon_backlight.c only functional when -DCONFIG_PMAC_BACKLIGHT,
JimC> even though the pmac routines are all ifdef'ed?

Michael> Did you actually test wether it works? As far as I know,
Michael> only Apple (PowerPC) hardware uses these registers yet
Michael> and have no use anywhere else.

No, I only noticed the file by coincidence and wanted to find out
about it before testing.

Thanks for the quick reply!

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
