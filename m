Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265896AbRF3MDC>; Sat, 30 Jun 2001 08:03:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265897AbRF3MCw>; Sat, 30 Jun 2001 08:02:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:14089 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265896AbRF3MCe>;
	Sat, 30 Jun 2001 08:02:34 -0400
Date: Sat, 30 Jun 2001 13:02:32 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, kaos@ocs.com.au,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.6-pre6: numerous dep_{bool,tristate} $CONFIG_ARCH_xxx bugs
Message-ID: <20010630130232.C12788@flint.arm.linux.org.uk>
In-Reply-To: <20010630125855.B12788@flint.arm.linux.org.uk> <E15GJR8-0001xJ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15GJR8-0001xJ-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sat, Jun 30, 2001 at 01:01:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 30, 2001 at 01:01:18PM +0100, Alan Cox wrote:
> No we are talking about Config.in scripts

No.  My comment was in reply to your specific case 2 of dep_tristate.
There were no if statements in there.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

