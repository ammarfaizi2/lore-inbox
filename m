Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263135AbUKTRXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263135AbUKTRXv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 12:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263132AbUKTRXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 12:23:51 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13834 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263135AbUKTRXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 12:23:48 -0500
Date: Sat, 20 Nov 2004 17:23:45 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: sparse segfaults
Message-ID: <20041120172345.G13550@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20041120143755.E13550@flint.arm.linux.org.uk> <Pine.LNX.4.58.0411200853150.20993@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0411200853150.20993@ppc970.osdl.org>; from torvalds@osdl.org on Sat, Nov 20, 2004 at 08:58:28AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 20, 2004 at 08:58:28AM -0800, Linus Torvalds wrote:
> Trivial fix checked in and pushed out. Thanks,

Confirmed fixed, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
