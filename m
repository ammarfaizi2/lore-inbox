Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262106AbVC1XLh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262106AbVC1XLh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 18:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVC1XLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 18:11:36 -0500
Received: from mail.kroah.org ([69.55.234.183]:14020 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262106AbVC1XLb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 18:11:31 -0500
Date: Mon, 28 Mar 2005 15:09:15 -0800
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/pci/hotplug/cpqphp_core.c: fix a check after use
Message-ID: <20050328230915.GA5044@kroah.com>
References: <20050325002155.GJ3966@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050325002155.GJ3966@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 01:21:55AM +0100, Adrian Bunk wrote:
> This patch fixes a check after use found by the Coverity checker.

Applied, thanks.

greg k-h
