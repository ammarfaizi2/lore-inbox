Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWFZJJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWFZJJR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 05:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbWFZJJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 05:09:17 -0400
Received: from koto.vergenet.net ([210.128.90.7]:27320 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1751310AbWFZJJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 05:09:16 -0400
From: Horms <horms@verge.net.au>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Andrew Morton <akpm@osdl.org>, Neela.Kolli@engenio.com,
       linux-scsi@vger.kernel.org, mike.miller@hp.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: Re: [RFC] [PATCH 2/2] kdump: cciss driver initialization?issue fix
In-Reply-To: <m1veqqxyrb.fsf@ebiederm.dsl.xmission.com>
X-Newsgroups: gmane.comp.boot-loaders.fastboot.general,gmane.linux.scsi,gmane.linux.kernel
User-Agent: tin/1.8.2-20060425 ("Shillay") (UNIX) (Linux/2.6.16-2-686 (i686))
Message-Id: <20060626090915.CA8333402A@koto.vergenet.net>
Date: Mon, 26 Jun 2006 18:09:15 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <m1veqqxyrb.fsf@ebiederm.dsl.xmission.com> you wrote:
> 
> Not all pci busses support it but there is a standard pci bus reset bit
> in pci bridges.
> 
> I don't know if it would help but it might make sense to have a config
> option that can be used to mark drivers that are known to have problems,
> in these scenarios.
> 
> CONFIG_BRITTLE_INIT perhaps?
> 
> It would at least make it easier for people to see which drivers
> they don't want to use, and give people some incentive to fix things.

I believe that MPT Fusion could go on that list.

http://permalink.gmane.org/gmane.linux.ports.ia64/14451



-- 
Horms                                           
H: http://www.vergenet.net/~horms/          W: http://www.valinux.co.jp/en/

