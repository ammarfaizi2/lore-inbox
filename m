Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbVAJTTe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVAJTTe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 14:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVAJTN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 14:13:29 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48398 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262470AbVAJTIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 14:08:14 -0500
Date: Mon, 10 Jan 2005 19:08:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove SPF-using wbsd lists from MAINTAINERS
Message-ID: <20050110190809.A10365@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	linux-kernel@vger.kernel.org
References: <20050110184307.GB2903@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050110184307.GB2903@stusta.de>; from bunk@stusta.de on Mon, Jan 10, 2005 at 07:43:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2005 at 07:43:07PM +0100, Adrian Bunk wrote:
> <drzeus-wbsd@drzeus.cx>:
> Connected to 213.115.189.212 but sender was rejected.
> Remote host said: 417 SPF error mailout.stusta.mhn.de: Address does not 
> pass the
> +Sender Policy Framework
> I'm not going to try again; this message has been in the queue too long.
> 
> IMHO lists rejecting emails based on some non-standard extension don't 
> belong into MAINTAINERS.

I assume as you removed Pierre Ossman's email address as well that
you apply the same argument to peoples email addresses?

(Not that I'm endorsing SPF in any way - discussions about SPF are
*off topic* here.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
