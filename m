Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVCRBTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVCRBTQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 20:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261423AbVCRBTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 20:19:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:46287 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261416AbVCRBTL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 20:19:11 -0500
Date: Thu, 17 Mar 2005 17:17:46 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: mdharm-usb@one-eyed-alien.net, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/usb/storage/: cleanups
Message-ID: <20050318011746.GB7994@kroah.com>
References: <20050301003758.GB4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050301003758.GB4021@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 01:37:58AM +0100, Adrian Bunk wrote:
> This patch contains the following cleanups:
> - make needlessly global code static
> - scsiglue.c: remove the unused usb_stor_sense_notready
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.

greg k-h

