Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTKSVJM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 16:09:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264084AbTKSVJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 16:09:12 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:54022 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263971AbTKSVJK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 16:09:10 -0500
Date: Wed, 19 Nov 2003 22:09:08 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Ludootje <ludootje@linux.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: instructions of 2.6 README not working
Message-ID: <20031119210908.GB11863@mars.ravnborg.org>
Mail-Followup-To: Ludootje <ludootje@linux.be>,
	linux-kernel@vger.kernel.org
References: <1069271692.17900.4.camel@libranet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069271692.17900.4.camel@libranet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 08:54:52PM +0100, Ludootje wrote:
> Hi,
> I just download 2.6-test9 and line 122 of the README says "sudo make O=/home/name/build/kernel install_modules install".
> This doesn't work though (at least not here). I tried this:
> $ su
> # make O=/mnt2/var/kernels/linux-2.6.0-test9/build modules
> # make O=/mnt2/var/kernels/linux-2.6.0-test9/build modules_install
> and it worked. I suppose this is a mistake in the README... no?

Stupid typo - I confuse install_modules with modules_install sometimes...
I will fix in the 2.6.1 timeframe - thanks.

	Sam
