Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283745AbRK3SCB>; Fri, 30 Nov 2001 13:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283737AbRK3SBv>; Fri, 30 Nov 2001 13:01:51 -0500
Received: from [212.18.232.186] ([212.18.232.186]:28933 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S283740AbRK3SBi>; Fri, 30 Nov 2001 13:01:38 -0500
Date: Fri, 30 Nov 2001 18:00:29 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: dalecki@evision.ag
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Henning Schmiedehausen <hps@intermeta.de>,
        Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Coding style - a non-issue
Message-ID: <20011130180029.C19193@flint.arm.linux.org.uk>
In-Reply-To: <E169rqb-0004G7-00@the-village.bc.nu> <3C07C4F9.A52C07F6@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C07C4F9.A52C07F6@evision-ventures.com>; from dalecki@evision-ventures.com on Fri, Nov 30, 2001 at 06:42:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 06:42:17PM +0100, Martin Dalecki wrote:
> serial.c should be hooked at the misc char device interface sooner or
> later.

Please explain.  Especially contentrate on justifing why serial interfaces
aren't a tty device.

Thanks.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

