Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263309AbUFTEpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263309AbUFTEpQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 00:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUFTEpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 00:45:16 -0400
Received: from mail.kroah.org ([65.200.24.183]:62421 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263309AbUFTEpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 00:45:12 -0400
Date: Sat, 19 Jun 2004 21:43:15 -0700
From: Greg KH <greg@kroah.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops inserting USB storage device
Message-ID: <20040620044315.GB10008@kroah.com>
References: <Pine.LNX.4.58.0406192049430.2228@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406192049430.2228@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 19, 2004 at 08:52:40PM -0400, Zwane Mwaikambo wrote:
> I got the following upon insertion of said USB device. Did the kobject get
> freed?

What kernel version?

thanks,

greg k-h
