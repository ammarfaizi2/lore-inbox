Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265915AbUBGAGZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 19:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266283AbUBGAGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 19:06:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:35463 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265915AbUBGAGX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 19:06:23 -0500
Date: Fri, 6 Feb 2004 16:00:02 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Steve Kieu <haiquy@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need help about scanner (2.6.2-mm1)
Message-Id: <20040206160002.6affbc82.rddunlap@osdl.org>
In-Reply-To: <20040206235749.19346.qmail@web10408.mail.yahoo.com>
References: <20040206235749.19346.qmail@web10408.mail.yahoo.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Feb 2004 10:57:49 +1100 (EST) Steve Kieu <haiquy@yahoo.com> wrote:


| Hi,
| 
| I noticed that 2.6.2-mm1, usb scanner is removed. With
| vanilla 2.6.2, this modules always OOP and somebody
| said we should use libusb instead. However after
| googling for a while I can not find any documentation
| how to use that even in the libusb homepage. Please
| help me , or pinpoint some place I could have some
| guides. Thank
| you.

Some distros ship it.
home page is http://libusb.sourceforge.net/

Use it with xsane for scanning.


--
~Randy
kernel-janitors project:  http://janitor.kernelnewbies.org/
