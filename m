Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbUKEXUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbUKEXUV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 18:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbUKEXSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 18:18:22 -0500
Received: from mail.kroah.org ([69.55.234.183]:7890 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261261AbUKEXSF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 18:18:05 -0500
Date: Fri, 5 Nov 2004 15:06:07 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] kill old PCI changelog
Message-ID: <20041105230607.GD31080@kroah.com>
References: <20041027205512.GD2713@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041027205512.GD2713@stusta.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2004 at 10:55:13PM +0200, Adrian Bunk wrote:
> There's not much value in shipping a changelog who's last update was 
> five years ago.
> 
> diffstat output:
>  arch/i386/pci/changelog |   62 ----------------------------------------
>  1 files changed, 62 deletions(-)


Applied, thanks.

greg k-h

