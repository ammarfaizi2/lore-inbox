Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262215AbSKMPy5>; Wed, 13 Nov 2002 10:54:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262218AbSKMPy5>; Wed, 13 Nov 2002 10:54:57 -0500
Received: from kim.it.uu.se ([130.238.12.178]:5588 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S262215AbSKMPy4>;
	Wed, 13 Nov 2002 10:54:56 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15826.30567.575933.742478@kim.it.uu.se>
Date: Wed, 13 Nov 2002 17:01:43 +0100
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Super I/O chip drivers?
In-Reply-To: <20021113143805.GA6319@suse.de>
References: <15826.24494.889156.510978@kim.it.uu.se>
	<20021113143805.GA6319@suse.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones writes:
 > On Wed, Nov 13, 2002 at 03:20:30PM +0100, Mikael Pettersson wrote:
 >  > I seem to recall that someone was doing drivers for
 >  > common Super I/O chips. Does anybody have any pointers
 >  > to this stuff?
 > 
 > http://www.devdrv.com/shsmod/
 > http://www.devdrv.co.jp/shsmod/shsmod17a-linux.tar.gz

Thanks, but that code only seems to do high-speed serial stuff, and
it doesn't support the IT8703-F chip I wanted to experiment with.
I was eventually (had to use Explorer, yuck) able to download some
specs from ITE's web site.

(I want to hack the ftape driver to use the high-speed "tape"
FDC mode supported by at least some Super I/O chips.)

/Mikael
