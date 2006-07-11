Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750995AbWGKKvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbWGKKvw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 06:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbWGKKvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 06:51:52 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:58601 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750995AbWGKKvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 06:51:51 -0400
Date: Tue, 11 Jul 2006 12:51:30 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Olaf Hering <olaf@aepfle.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Roman Zippel <zippel@linux-m68k.org>,
       torvalds@osdl.org, klibc@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [klibc] klibc and what's the next step?
Message-ID: <20060711105130.GA15759@mars.ravnborg.org>
References: <klibc.200606251757.00@tazenda.hos.anvin.org> <Pine.LNX.4.64.0606271316220.17704@scrub.home> <20060711044834.GA11694@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711044834.GA11694@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 06:48:34AM +0200, Olaf Hering wrote:
> 
> 24-klibc-basic-build-infrastructure.patch forces the klibc build, even for
> setups where it is not required. CONFIG_KLIBC, if it ever gets merged, should
> be optional.

Thats a 10 linier to usr/Kconfig - not a big deal to fix.
And agreed it shall not be compiled if not used/necessary.

So this part is more of a 'we shall fix' issue, and has nothing to do
with the direction of the future.

	Sam
