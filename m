Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030218AbWD0UKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030218AbWD0UKG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 16:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030221AbWD0UKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 16:10:06 -0400
Received: from main.gmane.org ([80.91.229.2]:21122 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030218AbWD0UKD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 16:10:03 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Heiko Joerg Schick <info@schihei.de>
Subject: Re: [PATCH 00/16] ehca: IBM eHCA InfiniBand Device   Driver
Date: Thu, 27 Apr 2006 21:50:28 +0200
Message-ID: <e2r7a0$fo2$1@sea.gmane.org>
References: <4450B378.9000705@de.ibm.com> <20060427125726.GK32127@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: p508176ef.dip.t-dialin.net
User-Agent: Unison/1.7.5
Cc: openib-general@openib.org, linuxppc-dev@ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-04-27 14:57:26 +0200, Jörn Engel <joern@wohnheim.fh-wedel.de> said:

> Don't expect much cheer and rejoicing over this.  I suspect that akpm
> or Linus will either want the 17 patches merged into one or have a
> patchset where every single patch leaves the kernel in a working
> state, including working eHCA driver.

I don't like the idea to put the whole driver in one patch file. I 
would propose to put the patch "ehca: integration in Linux kernel" last 
instead
of first, as Arnd mentioned. With that change we leave the kernel in a
working state when applying the patches.

Regards,
	Heiko


