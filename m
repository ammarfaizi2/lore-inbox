Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289212AbSAVJy2>; Tue, 22 Jan 2002 04:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289216AbSAVJyI>; Tue, 22 Jan 2002 04:54:08 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12553 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289212AbSAVJxz>; Tue, 22 Jan 2002 04:53:55 -0500
Date: Tue, 22 Jan 2002 09:53:47 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Joel Becker <jlbec@evilplan.org>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] WDIOC_SETTIMEOUT for 2.5.2
Message-ID: <20020122095347.A20650@flint.arm.linux.org.uk>
In-Reply-To: <20020122012608.T1929@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020122012608.T1929@parcelfarce.linux.theplanet.co.uk>; from jlbec@evilplan.org on Tue, Jan 22, 2002 at 01:26:09AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 01:26:09AM +0000, Joel Becker wrote:
> Folks,
> 	Here's the WDIOC_SETTIMEOUT patch against 2.5.2.

You've got some backup files in this patch that you might like to get
rid of:

> diff -uNr linux-2.5.2/drivers/char/ib700wdt.c~ linux-2.5.2-wd/drivers/char/ib700wdt.c~
> diff -uNr linux-2.5.2/drivers/char/softdog.c~ linux-2.5.2-wd/drivers/char/softdog.c~
> diff -uNr linux-2.5.2/drivers/char/wdt.c~ linux-2.5.2-wd/drivers/char/wdt.c~
> diff -uNr linux-2.5.2/drivers/char/wdt285.c~ linux-2.5.2-wd/drivers/char/wdt285.c~

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

