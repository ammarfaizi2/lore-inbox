Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314149AbSIADx3>; Sat, 31 Aug 2002 23:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314446AbSIADx3>; Sat, 31 Aug 2002 23:53:29 -0400
Received: from crack.them.org ([65.125.64.184]:42768 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S314149AbSIADx2>;
	Sat, 31 Aug 2002 23:53:28 -0400
Date: Sat, 31 Aug 2002 23:59:09 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Michael Obster <michael.obster@bingo-ev.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19 and binutils 2.13.90.0.3 dont compile
Message-ID: <20020901035909.GA15011@nevyn.them.org>
Mail-Followup-To: Michael Obster <michael.obster@bingo-ev.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3D710D21.5070101@bingo-ev.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D710D21.5070101@bingo-ev.de>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 31, 2002 at 08:38:25PM +0200, Michael Obster wrote:
> Hi,
> 
> can you have a look on that. Seems for me to be a problem with the new 
> binutils version, because with binutils 2.12.90.0.4 the kernel compiles. 
> Is there a workaround present?

The attached was a GCC error, the assembler is not even involved.  You
may want to check your GCC installations some more.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
