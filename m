Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318784AbSHWMbv>; Fri, 23 Aug 2002 08:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318785AbSHWMbv>; Fri, 23 Aug 2002 08:31:51 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8466 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318784AbSHWMbv>; Fri, 23 Aug 2002 08:31:51 -0400
Date: Fri, 23 Aug 2002 13:35:59 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Holger Schurig <h.schurig@mn-logistik.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cell-phone like keyboard driver anywhere?
Message-ID: <20020823133559.A21251@flint.arm.linux.org.uk>
References: <200208210932.36132.h.schurig@mn-logistik.de> <200208231205.28764.h.schurig@mn-logistik.de> <20020823113344.B20722@flint.arm.linux.org.uk> <200208231345.34487.h.schurig@mn-logistik.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208231345.34487.h.schurig@mn-logistik.de>; from h.schurig@mn-logistik.de on Fri, Aug 23, 2002 at 01:45:34PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2002 at 01:45:34PM +0200, Holger Schurig wrote:
> > Where is the user feedback normally associated with the action of
> > pressing "1-1-1-pause" ?  Most keypads I know display "a" then "b"
> > then "c" so the user knows what character they're going to get.
> 
> There would be none (maybe a keyboard buzzer).

Ok, well, I think there may be an example of one in the -rmk patch (aka
arm) ftp://ftp.arm.linux.org.uk/pub/armlinux/kernel/v2.5

See linux/drivers/char/clps711x_keyb.c

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

