Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262547AbUEAXIk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262547AbUEAXIk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 19:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262585AbUEAXIk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 19:08:40 -0400
Received: from mail.kroah.org ([65.200.24.183]:57292 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262547AbUEAXIj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 19:08:39 -0400
Date: Sat, 1 May 2004 16:04:51 -0700
From: Greg KH <greg@kroah.com>
To: Duncan Sands <baldrick@free.fr>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [USBFS PATCH] change extern inline to static inline
Message-ID: <20040501230451.GB13676@kroah.com>
References: <200405020015.25851.baldrick@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405020015.25851.baldrick@free.fr>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 12:15:25AM +0200, Duncan Sands wrote:
> And change __inline__ to inline and get rid of an unused function
> while at it.

Applied, thanks.

greg k-h
