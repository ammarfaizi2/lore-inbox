Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbTIYXCq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 19:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbTIYXCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 19:02:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:6318 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261708AbTIYXCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 19:02:33 -0400
Date: Thu, 25 Sep 2003 16:00:41 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4 patch] fix USB_MOUSE help text
Message-ID: <20030925230041.GC30186@kroah.com>
References: <20030925131536.GU15696@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030925131536.GU15696@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 25, 2003 at 03:15:36PM +0200, Adrian Bunk wrote:
> The USB_MOUSE help text was obviously copied from the USB_KBD help text.
> The patch below does a s/keyboard/mouse/g

Applied, thanks.

greg k-h
