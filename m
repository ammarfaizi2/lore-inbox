Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267624AbRGZGAW>; Thu, 26 Jul 2001 02:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267627AbRGZGAN>; Thu, 26 Jul 2001 02:00:13 -0400
Received: from [200.222.195.52] ([200.222.195.52]:13740 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S267624AbRGZGAC>; Thu, 26 Jul 2001 02:00:02 -0400
Date: Thu, 26 Jul 2001 03:00:02 -0300
From: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <0@pervalidus.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unresolved symbols in 2.4.7 ppp_generic.o ?
Message-ID: <20010726030002.U11246@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.19i
X-Mailer: Mutt/1.3.19i - Linux 2.4.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Sorry. slhc is a module in 2.4.7 ? The only changes from my
2.4.6 build are the removal of dummy and slip.

Next time I'll do a make install_modules and not try other
methods.

depmod worked after I moved slhc.o to
/lib/modules/2.4.7/kernel/drivers/net/

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-2717-2399 (Niterói-RJ BR)
