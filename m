Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265036AbTGKS7t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 14:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbTGKS6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 14:58:32 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:58072
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S265061AbTGKSgZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 14:36:25 -0400
Date: Fri, 11 Jul 2003 14:51:05 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: gcc-3.3.1 breaks kernel
Message-ID: <20030711185105.GG16037@gtf.org>
References: <20030711175947.GC2791@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030711175947.GC2791@werewolf.able.es>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 11, 2003 at 07:59:47PM +0200, J.A. Magallon wrote:
> Any brave soul there is using a prerelease of gcc-3.3.1 to build kernels ?
> (don't know if RawHide or SuSE beta or any other have that, apart from
> MandrakeCooker).

Debian has some amounts of 3.3.1 prerelease bits in -testing.

It seems to build bootable x86 kernels here in both 2.4 and 2.5.

(however, note my .configs only contain drivers and subsystems that are
absolutely necessary)

	Jeff



