Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUCPPW5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 10:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbUCPPW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 10:22:56 -0500
Received: from mail.renesas.com ([202.234.163.13]:39866 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262238AbUCPPWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 10:22:31 -0500
Date: Wed, 17 Mar 2004 00:22:23 +0900 (JST)
Message-Id: <20040317.002223.1049904223.takata.hirokazu@renesas.com>
To: linux-kernel@vger.kernel.org
Cc: takata@linux-m32r.org
Subject: [PATCH] m32r - patch for v2.6.0 kernel
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Linus and folks,

> And what about a 2.6 port? :-)
Yes!  Here is an m32r patch to the 2.6.0 stock kernel. :-)

The patch information is slight bigger, so I placed it on our 
Linux/M32R homepage as well as the previous v2.4.19 patch.
- m32r architecture dependent portions
  http://www.linux-m32r.org/public/linux-2.6.0_m32r_20040316.arch-m32r.patch
- architecture independent portions for the m32r
  http://www.linux-m32r.org/public/linux-2.6.0_m32r_20040316.patch

> Also, please merge/move arch/m32r/drivers with/to drivers/.
Sorry, I have not done yet...

Best Regards,
--
Hirokazu Takata


From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] m32r - New architecure port to Renesas M32R processor 
Date: Tue, 2 Mar 2004 10:30:12 +0100 (MET)
> On Tue, 2 Mar 2004, Hirokazu Takata wrote:
> > We have ported Linux to the M32R processor, which is a 32-bit RISC embedded
> > microprocessor of Renesas Technology.
> >
> > I would like to release a patch information for this m32r port.
> 
> Nice!
> 
> > Would you merge them to the stock kernel?
> > # Unfortunately, I have linux-2.4.19 based kernel, not latest one.
> 
> However, I think you best upgrade to 2.4.25 first.
> Also, please merge/move arch/m32r/drivers with/to drivers/.
> 
> And what about a 2.6 port? :-)
> 
> > This new architecture port has already reported at OLS2003.
> > http://www.linux-m32r.org/cmn/m32r/ols2003_presentation.pdf
> > http://archive.linuxsymposium.org/ols2003/Proceedings/All-Reprints/Reprint-Takata-OLS2003.pdf
> 
> I attended that one, and it looked quite nice!
> 
> Gr{oetje,eeting}s,
> 
> 						Geert

