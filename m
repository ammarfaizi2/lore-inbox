Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268468AbUI2NxB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268468AbUI2NxB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268372AbUI2Ntm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:49:42 -0400
Received: from p5089E8E5.dip.t-dialin.net ([80.137.232.229]:1796 "EHLO
	timbaland.dnsalias.org") by vger.kernel.org with ESMTP
	id S268407AbUI2Nql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:46:41 -0400
From: Borislav Petkov <petkov@uni-muenster.de>
To: Dave Airlie <airlied@gmail.com>
Subject: Re: 2.6.9-rc2-mm4 drm and XFree oopses
Date: Wed, 29 Sep 2004 15:17:58 +0200
User-Agent: KMail/1.7
References: <20040929102840.GA11325@none> <21d7e99704092905284f48af35@mail.gmail.com>
In-Reply-To: <21d7e99704092905284f48af35@mail.gmail.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409291517.58750.petkov@uni-muenster.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 September 2004 14:28, Dave Airlie wrote:
> It might help if you enabled AGP for your chipset, you have no agp
> compiled in for your Intel motherboard, you need intel agp chipset
> support..
>
> Dave.
<snip>
Hi Dave,
do you mean the CONFIG_AGP_INTEL option? Because my chipset is ICH4 and the 
help text for that option doesn't mention support for ICH4 chipsets.

Regards,
Boris.

