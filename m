Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264300AbTCXQjT>; Mon, 24 Mar 2003 11:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264303AbTCXQi4>; Mon, 24 Mar 2003 11:38:56 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20999 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264300AbTCXQif>; Mon, 24 Mar 2003 11:38:35 -0500
Date: Mon, 24 Mar 2003 16:49:40 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: davej@codemonkey.org.uk
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: add support for 8 port lava octo cards to 8250_pci
Message-ID: <20030324164940.D10370@flint.arm.linux.org.uk>
Mail-Followup-To: davej@codemonkey.org.uk, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <200303241642.h2OGg635008297@deviant.impure.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200303241642.h2OGg635008297@deviant.impure.org.uk>; from davej@codemonkey.org.uk on Mon, Mar 24, 2003 at 04:41:53PM +0000
X-Message-Flag: Your copy of Microsoft Outlook is vurnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 24, 2003 at 04:41:53PM +0000, davej@codemonkey.org.uk wrote:
> diff -urpN --exclude-from=/home/davej/.exclude bk-linus/drivers/serial/8250_pci.c linux-2.5/drivers/serial/8250_pci.c
> --- bk-linus/drivers/serial/8250_pci.c	2003-03-16 14:16:04.000000000 +0000
> +++ linux-2.5/drivers/serial/8250_pci.c	2003-03-17 23:42:35.000000000 +0000

Thanks, Applied.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

