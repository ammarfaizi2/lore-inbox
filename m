Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267363AbUJGJrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267363AbUJGJrS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 05:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269779AbUJGJrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 05:47:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:15530 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267363AbUJGJn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 05:43:56 -0400
Date: Thu, 7 Oct 2004 11:43:54 +0200
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: x86-64 config warning
Message-ID: <20041007094354.GA21807@wotan.suse.de>
References: <4164BFA6.2070702@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4164BFA6.2070702@pobox.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2004 at 12:01:42AM -0400, Jeff Garzik wrote:
> In 2.6.9-rc3:
> 
> [...]
>   UPD     include/linux/version.h
> scripts/kconfig/conf -s arch/x86_64/Kconfig
> Warning! Found recursive dependency: UNORDERED_IO UNORDERED_IO
> #

Should be already fixed. 

-Andi
