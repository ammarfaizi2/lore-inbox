Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVBAQ5V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVBAQ5V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 11:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbVBAQ5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 11:57:20 -0500
Received: from mail.kroah.org ([69.55.234.183]:50334 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262068AbVBAQ5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 11:57:12 -0500
Date: Tue, 1 Feb 2005 08:55:49 -0800
From: Greg KH <greg@kroah.com>
To: Aurelien Jarno <aurelien@aurel32.net>, Alexey Dobriyan <adobriyan@mail.ru>,
       linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Subject: Re: [PATCH 2.6] I2C: New chip driver: sis5595
Message-ID: <20050201165549.GE23118@kroah.com>
References: <200502011420.17466.adobriyan@mail.ru> <20050201121414.GA15219@bode.aurel32.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050201121414.GA15219@bode.aurel32.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2005 at 01:14:14PM +0100, Aurelien Jarno wrote:
> +	if(force_addr)

Please put a space after the "if" and before the "(".  You do this in a
number of places.

thanks,

greg k-h
