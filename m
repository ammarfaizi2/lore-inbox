Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbUKCIoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbUKCIoG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 03:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbUKCIoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 03:44:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:928 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261473AbUKCIoB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 03:44:01 -0500
Date: Wed, 3 Nov 2004 09:43:30 +0100
From: Jens Axboe <axboe@suse.de>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: still no cd/dvd burning as user with 2.6.9
Message-ID: <20041103084330.GB10434@suse.de>
References: <41889857.5040506@tequila.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41889857.5040506@tequila.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 03 2004, Clemens Schwaighofer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi,
> 
> I use 2.6.9-ac3 on my Laptop and I just wanted to burn a DVD-Video with
> my external Pioneer DVD writer which is connected via fire-wire to the
> Laptop.
> 
> Before 2.6.9-ac3 I used 2.6.9-rc2-mm2 and with this I could write CDs/DVDs.
> 
> <rant>
> So why is it still impossible that users can write CDs/DVDs. I, as a
> user, find this rather ridicolous that you have to patch the kernel to
> get this simple thing running. Security is important, yes, but this is
> just annoying.
> 
> I really hope that gets fixed soon, because its just annoying to reboot
> to a different kernel, just to write CDs ...
> </rant>

It should work, are the permissions on your device file correct?

-- 
Jens Axboe

