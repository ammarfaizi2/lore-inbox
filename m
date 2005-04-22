Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVDVVS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVDVVS5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 17:18:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbVDVVQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 17:16:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:26079 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262135AbVDVVQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 17:16:30 -0400
Date: Fri, 22 Apr 2005 14:14:55 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: pe1rxq@amsat.org, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/usb/net/zd1201.c: make some code static
Message-ID: <20050422211455.GD1983@kroah.com>
References: <20050418021228.GE3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050418021228.GE3625@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 04:12:28AM +0200, Adrian Bunk wrote:
> This patch makes some needlessly global code static.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.

greg k-h
