Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVDHAVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVDHAVV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 20:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbVDHAVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 20:21:21 -0400
Received: from mail.kroah.org ([69.55.234.183]:19588 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262636AbVDHAU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 20:20:59 -0400
Date: Thu, 7 Apr 2005 17:20:04 -0700
From: Greg KH <gregkh@suse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: fix stale PCI pm docs
Message-ID: <20050408002004.GE7010@kroah.com>
References: <20050405214949.GA1881@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050405214949.GA1881@elf.ucw.cz>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 11:49:49PM +0200, Pavel Machek wrote:
> Hi!
> 
> This fixes u32 vs. pm_message_t confusion in documentation, and
> removes references to no-longer-existing (*save_state), too. With
> exception of USB (I hope David will fix/apply my patch), this should
> fix last piece of this confusion... famous last words.

Applied, thanks.

greg k-h
