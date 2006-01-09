Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWAJNti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWAJNti (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 08:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbWAJNti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 08:49:38 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:57805 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751042AbWAJNth (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 08:49:37 -0500
Date: Mon, 9 Jan 2006 20:26:44 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Ben Collins <ben.collins@ubuntu.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH]: How to be a kernel driver maintainer
Message-ID: <20060109192644.GA18175@elf.ucw.cz>
References: <1136736455.24378.3.camel@grayson>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136736455.24378.3.camel@grayson>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Since this discussion of getting driver authors to submit their driver
> for inclusion I started writing a document to send them. I think it's
> best included in the kernel tree.
> 
> Signed-off-by: Ben Collins <bcollins@ubuntu.com>

Well, nice document, but it does not really match the title. I
expected something like "how to be Jeff Garzik" and it is more "how to
get your driver into kernel and keep it there". It does not deal with
taking patches from other people, etc... I think it should go into
submitting driver howto or something like that.

							Pavel

> --- /dev/null	2006-01-05 16:54:17.144000000 -0500
> +++ b/Documentation/HOWTO-KernelMaintainer	2006-01-08 11:02:34.000000000 -0500
> @@ -0,0 +1,150 @@
> +                  How to be a kernel driver maintainer
> +                  ------------------------------------
> +
> +
> +This document explains what you must know before becoming the maintainer
> +of a portion of the Linux kernel. Please read SubmittingPatches and
> +SubmittingDrivers and CodingStyle, also in the Documentation/ directory.


-- 
Thanks, Sharp!
