Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVC1UuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVC1UuF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 15:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262075AbVC1UuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 15:50:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:59349 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262064AbVC1Ur4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 15:47:56 -0500
Date: Mon, 28 Mar 2005 12:45:24 -0800
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: gregkh@suse.de, linux-usb-devel@lists.sourceforge.ne.kroah.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/usb/misc/usbtest.c: fix a NULL dereference
Message-ID: <20050328204524.GF3491@kroah.com>
References: <20050325010629.GN3966@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050325010629.GN3966@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 02:06:29AM +0100, Adrian Bunk wrote:
> This patch fixes a NULL dereference found by the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.

greg k-h

