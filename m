Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280126AbRKIVFo>; Fri, 9 Nov 2001 16:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280120AbRKIVFe>; Fri, 9 Nov 2001 16:05:34 -0500
Received: from a245d15hel.dial.kolumbus.fi ([212.54.8.245]:64627 "EHLO
	porkkala.jlaako.pp.fi") by vger.kernel.org with ESMTP
	id <S280126AbRKIVFR>; Fri, 9 Nov 2001 16:05:17 -0500
Message-ID: <3BEC44ED.B33682B5@kolumbus.fi>
Date: Fri, 09 Nov 2001 23:04:45 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Cyrus <cyjamten@ihug.com.au>, linux-kernel@vger.kernel.org
Subject: Re: AMD761Agpgart+Radeon64DDR+kernel+2.4.14...no go...
In-Reply-To: <E161ybE-00016l-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > I have similar configuration. Solution is to use latest -ac kernels and 
> > CVS version on XFree86...
> >
> > A7M266, RADEON DDR VE
> 
> Everything needed should already be in Linus tree and current XFree86

XFree86 4.1.0 doesn't work. Neither did rawhide 4.1.0 ~two months ago.
Result was usually blank screen without signal and deadlock. Some versions
did work when agpgart and DRI was disabled. Only CVS version worked with
agpgart and DRI. Latest radeon DRI kernel module has been working for few
months.

Haven't been testing RedHat's versions of XFree86 since switching to CVS
version.


 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers
