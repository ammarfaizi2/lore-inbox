Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317091AbSIAOqe>; Sun, 1 Sep 2002 10:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317096AbSIAOqe>; Sun, 1 Sep 2002 10:46:34 -0400
Received: from crack.them.org ([65.125.64.184]:49937 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S317091AbSIAOqe>;
	Sun, 1 Sep 2002 10:46:34 -0400
Date: Sun, 1 Sep 2002 10:52:16 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Michael Obster <michael.obster@bingo-ev.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19 and binutils 2.13.90.0.3 dont compile
Message-ID: <20020901145216.GA12864@nevyn.them.org>
Mail-Followup-To: Michael Obster <michael.obster@bingo-ev.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3D710D21.5070101@bingo-ev.de> <20020901035909.GA15011@nevyn.them.org> <3D71FCEB.6060707@bingo-ev.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D71FCEB.6060707@bingo-ev.de>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 01, 2002 at 01:41:31PM +0200, Michael Obster wrote:
> Hi,
> 
> >
> >The attached was a GCC error, the assembler is not even involved.  You
> >may want to check your GCC installations some more.
> >
> i dont see any error on the gcc installation. it must be a library or 
> could it be a buggy version of bin86. Have 0.16.8 installed.

No, it is definitely an error deliver by GCC based on source code, so
it is a GCC problem.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
