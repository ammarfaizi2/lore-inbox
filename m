Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263937AbVBEB7m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbVBEB7m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 20:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264206AbVBEB7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 20:59:40 -0500
Received: from mail.kroah.org ([69.55.234.183]:34245 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266194AbVBEB4a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 20:56:30 -0500
Date: Fri, 4 Feb 2005 17:56:10 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, bernard@blackham.com.au,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: driver model: fix types in usb
Message-ID: <20050205015610.GA31700@kroah.com>
References: <20050202202610.GA1948@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050202202610.GA1948@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 09:26:10PM +0100, Pavel Machek wrote:
> Hi!
> 
> From: Bernard Blackham <bernard@blackham.com.au>
> 
> This fixes types in USB w.r.t. driver model. It should not actually
> change any code. Please apply,
> 
> 								Pavel
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>

Applied to my trees, thanks.

greg k-h
