Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265344AbUFRWMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265344AbUFRWMZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 18:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbUFRWMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 18:12:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:29059 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262208AbUFRWId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 18:08:33 -0400
Date: Fri, 18 Jun 2004 15:04:39 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <rol@as2917.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] save kernel version in .config file
Message-Id: <20040618150439.25a57d05.rddunlap@osdl.org>
In-Reply-To: <200406180638.i5I6cwX12193@tag.witbe.net>
References: <20040617220651.0ceafa91.rddunlap@osdl.org>
	<200406180638.i5I6cwX12193@tag.witbe.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004 08:38:58 +0200 Paul Rolland wrote:

| Hello,
| 
| > 
| > Is this interesting to anyone besides me?
| > 
| Is it also possible to have this version being displayed during
| a make config/make menuconfig/... so that we know we are reading a
| config file that may have been generated for another kernel version,
| and not yet saved ?
| 
| You would have, for make menuconfig :
| 
|  Linux Kernel v2.2.13 Configuration, Configuration file version 2.4.20

Sure, it's possible.  I just don't want to add the kitchen sink.

IOW, I'm not convinced that it's useful most of the time...
only a little bit of the time.

--
~Randy
