Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbULPX7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbULPX7u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 18:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbULPX7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 18:59:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:42461 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262206AbULPX7m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 18:59:42 -0500
Date: Thu, 16 Dec 2004 15:56:21 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] arch/i386/pci/: make some code static
Message-ID: <20041216235621.GB11424@kroah.com>
References: <20041212021058.GM22324@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041212021058.GM22324@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2004 at 03:10:58AM +0100, Adrian Bunk wrote:
> The patch below makes some needlessly global code static.
> 
> 
> diffstat output:
>  arch/i386/pci/fixup.c |    4 ++--
>  arch/i386/pci/irq.c   |    4 +++-
>  arch/i386/pci/pci.h   |    2 --
>  3 files changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

greg k-h
