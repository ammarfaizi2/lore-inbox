Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVC1XXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVC1XXb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 18:23:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVC1XXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 18:23:30 -0500
Received: from mail.kroah.org ([69.55.234.183]:44747 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262114AbVC1XXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 18:23:24 -0500
Date: Mon, 28 Mar 2005 15:21:51 -0800
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: tom.l.nguyen@intel.com, gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [2.6 patch] drivers/pci/msi.c: fix a check after use
Message-ID: <20050328232151.GB5265@kroah.com>
References: <20050327211524.GE4285@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050327211524.GE4285@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 11:15:24PM +0200, Adrian Bunk wrote:
> This patch fixes a check after use found by the Coverity checker.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.

greg k-h
