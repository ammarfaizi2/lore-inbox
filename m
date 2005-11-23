Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVKWTHT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVKWTHT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:07:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932232AbVKWTHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:07:18 -0500
Received: from mail.kroah.org ([69.55.234.183]:50887 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932227AbVKWTHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:07:16 -0500
Date: Wed, 23 Nov 2005 11:02:37 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: gregkh@suse.de, Thomas Winischhofer <thomas@winischhofer.net>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/usb/misc/sisusbvga/sisusb.c: remove dead code
Message-ID: <20051123190237.GA28080@kroah.com>
References: <20051120232239.GI16060@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051120232239.GI16060@stusta.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 12:22:39AM +0100, Adrian Bunk wrote:
> The Coverity checker found this obviously dead code.

I think the checker is wrong, this does not look correct to me.

thanks,

greg k-h
