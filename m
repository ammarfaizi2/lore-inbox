Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262072AbVC1Uw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262072AbVC1Uw3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 15:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbVC1UuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 15:50:19 -0500
Received: from mail.kroah.org ([69.55.234.183]:62677 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262072AbVC1Ur7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 15:47:59 -0500
Date: Mon, 28 Mar 2005 12:45:37 -0800
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: gregkh@suse.de, linux-usb-devel@lists.sourceforge.ne.kroah.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/usb/class/usb-midi.c: remove dead code
Message-ID: <20050328204536.GG3491@kroah.com>
References: <20050325010512.GM3966@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050325010512.GM3966@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 02:05:12AM +0100, Adrian Bunk wrote:
> This patch removes some obviously dead code found by the Coverity 
> checker.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.

greg k-h

