Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263815AbUECSXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263815AbUECSXN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 14:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263827AbUECSXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 14:23:13 -0400
Received: from [216.150.199.16] ([216.150.199.16]:9383 "EHLO mail.aspsys.com")
	by vger.kernel.org with ESMTP id S263815AbUECSXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 14:23:10 -0400
Date: Mon, 3 May 2004 12:23:08 -0600
From: Bryan Stillwell <bryans@aspsys.com>
To: Jason Turner <Jason.Turner@ColoradoVnet.com>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Dual Opteron 248s w/ 8GB RAM on Tyan K8W (S2885)
Message-ID: <20040503182308.GB16122@aspsys.com>
References: <E45C36E01BB62E4ABE34C82372A928E0020A32@iron.Vnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E45C36E01BB62E4ABE34C82372A928E0020A32@iron.Vnet.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 12:02:26PM -0600, Jason Turner wrote:
>A similar (but different) problem exists with motherboards that use the
>AMD760MPX. Here is the specific problem you are seeing:
>
>>From Tyan's FAQ:(http://www.tyan.com/support/html/f_s2885.html)

I tried the beta bios mentioned in Tyan's FAQ, but it didn't help with
the booting problem I have with 8GB ram.  I did however find that I can
boot up the machine if I add "maxcpus=0" to the kernel options in the
bootloader.  Of course then only one cpu works, which is just as bad as
the other solution of having only half the memory...

Bryan

-- 
Aspen Systems, Inc.    | http://www.aspsys.com/
Production Engineer    | Phone: (303)431-4606
bryans@aspsys.com      | Fax:   (303)431-7196
