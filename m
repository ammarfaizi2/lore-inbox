Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbTLEQgU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 11:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264254AbTLEQgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 11:36:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:45495 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264229AbTLEQew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 11:34:52 -0500
Date: Fri, 5 Dec 2003 08:27:27 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Lucio Maciel <lucio.maciel@agrofel.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where'd the .config go?
Message-Id: <20031205082727.556c3634.rddunlap@osdl.org>
In-Reply-To: <1070566824.30087.2.camel@walker.agrofel.com.br>
References: <20031204151852.GB16568@rdlg.net>
	<20031204083331.7660077a.rddunlap@osdl.org>
	<1070566824.30087.2.camel@walker.agrofel.com.br>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Dec 2003 17:40:25 -0200 Lucio Maciel <lucio.maciel@agrofel.com.br> wrote:

| Hi
| 
| On Thu, 2003-12-04 at 14:33, Randy.Dunlap wrote:
| > On Thu, 4 Dec 2003 10:18:52 -0500 "Robert L. Harris" <Robert.L.Harris@rdlg.net> wrote:
| > 
| > | 
| > | 
| > | Just compiled 2.4.23-bk3 and noticed that the option to save the .config
| > | somewhere in the kernel is missing.  Mistake somewhere or has this been
| > | removed?
| > 
| > It's never been merged in 2.4.x.  Marcelo didn't want it.
| > It's in 2.6.x.
| 
| There is a reason for this is not in 2.4?
| Not essential, but it is a good help.

It's Marcelo's decision and he's trying to reduce 2.4.x patches.

| > There's a 2.4.22-pre patch in this dir that you can try:
| >   http://www.xenotime.net/linux/ikconfig/
| > 
| Again i'll have to patch every kernel, like XFS?

Right.

--
~Randy
MOTD:  Always include version info.
