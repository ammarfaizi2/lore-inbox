Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135266AbRDWOtV>; Mon, 23 Apr 2001 10:49:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135267AbRDWOtC>; Mon, 23 Apr 2001 10:49:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54544 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S135266AbRDWOsd>;
	Mon, 23 Apr 2001 10:48:33 -0400
Date: Mon, 23 Apr 2001 15:48:21 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: mythos <papadako@csd.uoc.gr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Can't compile 2.4.3 with agcc
Message-ID: <20010423154821.A26340@flint.arm.linux.org.uk>
In-Reply-To: <Pine.GSO.4.33.0104231611090.15682-100000@iridanos.csd.uch.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.33.0104231611090.15682-100000@iridanos.csd.uch.gr>; from papadako@csd.uoc.gr on Mon, Apr 23, 2001 at 04:13:47PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2001 at 04:13:47PM +0300, mythos wrote:
> Using gcc version pgcc-2.95.3 19991024 (AthlonGCC-0.0.3ex3.1)
> I can't compile 2.4.3.I get the follow message:
> 
> init/main.o: In function `check_fpu':
> init/main.o(.text.init+0x65): undefined reference to
> `__buggy_fxsr_alignment'
> make: *** [vmlinux] Error 1
> 
> Can anyone help me?

This is a FAQ!  (sorry, but I don't know if it is in a FAQ or not).

IIRC, you can't use pgcc to compile linux kernels.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

