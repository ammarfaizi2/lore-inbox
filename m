Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVC1Uwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVC1Uwa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 15:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVC1UuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 15:50:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:60629 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262068AbVC1Ur5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 15:47:57 -0500
Date: Mon, 28 Mar 2005 12:44:47 -0800
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/usb/media/usbvideo.c: fix a check after use
Message-ID: <20050328204446.GD3491@kroah.com>
References: <20050327204852.GC4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050327204852.GC4285@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 10:48:52PM +0200, Adrian Bunk wrote:
> This patch fixes a check after use found by the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.

greg k-h

