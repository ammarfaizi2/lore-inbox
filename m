Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271829AbTGRPGu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 11:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271781AbTGRPD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 11:03:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:57323 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271972AbTGROUv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 10:20:51 -0400
Date: Fri, 18 Jul 2003 07:33:19 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: alan@lxorguk.ukuu.org.uk, geert@linux-m68k.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PATCH: typo bits
Message-Id: <20030718073319.37d7863f.rddunlap@osdl.org>
In-Reply-To: <20030718152947.B3019@pclin040.win.tue.nl>
References: <Pine.GSO.4.21.0307181221390.22944-100000@vervain.sonytel.be>
	<1058528165.19558.3.camel@dhcp22.swansea.linux.org.uk>
	<20030718152947.B3019@pclin040.win.tue.nl>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jul 2003 15:29:47 +0200 Andries Brouwer <aebr@win.tue.nl> wrote:

| On Fri, Jul 18, 2003 at 12:36:05PM +0100, Alan Cox wrote:
| 
| > > > - * It's now support isochronous mode and more effective than hc_sl811.o
| > > > + * It's now support isosynchronous mode and more effective than hc_sl811.o
| > > 
| > > I thought the correct term was `isochronous'...
| > 
| > Perhaps someone can clarify - however isochornus is definitely wrong either way
| 
| You are the native English speaker here. Isosynchronous is (was?) not an
| English word.
| 
| Oh, but we aren't speaking English - this is about USB devices.
| Read the USB standard and see that it has an isosynchronous mode.

It does?  I can't find it in the main USB 2.0 spec.
It discusses isochronous, which is what I would prefer to see,
regardless of the USB spec.

--
~Randy
