Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265993AbUBPXpO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 18:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265999AbUBPXpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 18:45:14 -0500
Received: from mail.kroah.org ([65.200.24.183]:5080 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265993AbUBPXpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 18:45:10 -0500
Date: Mon, 16 Feb 2004 15:36:56 -0800
From: Greg KH <greg@kroah.com>
To: Andrei Mikhailovsky <andrei@arhont.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2 khubd oops
Message-ID: <20040216233656.GA23911@kroah.com>
References: <4030CA24.1090106@arhont.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4030CA24.1090106@arhont.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 16, 2004 at 01:48:20PM +0000, Andrei Mikhailovsky wrote:
> If anyone interested, I have an oops everytime i use and disconnect a
> scanner device

That's one reason why this driver is now gone from the kernel tree.
Please do not use it anymore, it is not needed.

thanks,

greg k-h
