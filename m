Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964950AbVHYMD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964950AbVHYMD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 08:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964951AbVHYMD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 08:03:26 -0400
Received: from isilmar.linta.de ([213.239.214.66]:19418 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S964950AbVHYMD0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 08:03:26 -0400
Date: Thu, 25 Aug 2005 14:03:20 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Pavel Machek <pavel@suse.cz>
Cc: axboe@suse.de, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.13-rc7: crash on removing CF card
Message-ID: <20050825120320.GA22920@isilmar.linta.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	Pavel Machek <pavel@suse.cz>, axboe@suse.de,
	kernel list <linux-kernel@vger.kernel.org>
References: <20050825094846.GA2097@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825094846.GA2097@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Aug 25, 2005 at 11:48:46AM +0200, Pavel Machek wrote:
> Something went wrong with PCMCIA on this X32. I inserted CF card, but
> it detected both hde *and* hdf, mount took forever. At that point I
> decided that I want my CF card back, took it back, it started
> producing different I/O errors , and then it oopsed.

Did this happen also with 2.6.13-rc[3-6]?

Thanks,
	Dominik
