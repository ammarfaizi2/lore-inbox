Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVBURNP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVBURNP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 12:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVBURNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 12:13:14 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:62482 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262041AbVBURMe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 12:12:34 -0500
Date: Mon, 21 Feb 2005 17:12:28 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stas Sergeev <stsp@aknet.ru>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: lockup when accessing serial port (and fix)
Message-ID: <20050221171228.A2768@flint.arm.linux.org.uk>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Stas Sergeev <stsp@aknet.ru>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4207CFED.8020509@aknet.ru> <1108998210.15518.95.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1108998210.15518.95.camel@localhost.localdomain>; from alan@lxorguk.ukuu.org.uk on Mon, Feb 21, 2005 at 03:03:32PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2005 at 03:03:32PM +0000, Alan Cox wrote:
> Known bug, just nobody has bothered to fix it. Please send the fix to
> Linus so it gets into 2.6.11

Alan,

The fix was submitted to and accepted by Linus on Feb 8th.  Therefore,
there's nothing to "bother" with.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
