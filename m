Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVAaS3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVAaS3y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 13:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbVAaS3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 13:29:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:32969 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261292AbVAaS3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 13:29:48 -0500
Date: Mon, 31 Jan 2005 10:29:28 -0800
From: Greg KH <greg@kroah.com>
To: Aur?lien Jarno <aurelien@aurel32.net>, sensors@Stimpy.netroedge.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] I2C: lm78 driver improvement
Message-ID: <20050131182927.GE21546@kroah.com>
References: <20050125221819.GB23560@bode.aurel32.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125221819.GB23560@bode.aurel32.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 11:18:19PM +0100, Aur?lien Jarno wrote:
> Hi Greg,
> 
> The following patch against kernel 2.6.11-rc2-mm1 improves the lm78
> driver. I used it as a model to port the sis5595 driver to the 2.6
> kernel, and I then applied the changes suggested by Jean Delvare on 
> the sis5595 driver to this one.

Applied, thanks.

greg k-h
