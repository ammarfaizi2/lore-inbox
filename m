Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbUEQSPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUEQSPS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 14:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUEQSPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 14:15:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:53181 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262063AbUEQSPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 14:15:15 -0400
Date: Mon, 17 May 2004 11:02:38 -0700
From: Greg KH <greg@kroah.com>
To: Zwane Mwaikambo <zwane@fsmlabs.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH][2.6] fix usb-serial serial_open oops
Message-ID: <20040517180236.GD3116@kroah.com>
References: <Pine.LNX.4.58.0405162033330.32571@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405162033330.32571@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 16, 2004 at 08:37:56PM -0400, Zwane Mwaikambo wrote:
> No usb serial devices, just compiled in and the system has a USB controller.

Ugh, I got a little to happy with deleting code, sorry about that.

I've applied your fix, thanks.

greg k-h
