Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262729AbTLDQ5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 11:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbTLDQ5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 11:57:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:40400 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262729AbTLDQ5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 11:57:08 -0500
Date: Thu, 4 Dec 2003 08:49:52 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Where'd the .config go?
Message-Id: <20031204084952.06317809.rddunlap@osdl.org>
In-Reply-To: <20031204164455.GD16568@rdlg.net>
References: <20031204151852.GB16568@rdlg.net>
	<20031204083331.7660077a.rddunlap@osdl.org>
	<20031204164455.GD16568@rdlg.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Dec 2003 11:44:56 -0500 "Robert L. Harris" <Robert.L.Harris@rdlg.net> wrote:

| 
| 
| Odd, it's in my 2.4.21-ac3 tree.  Guess it was in the ac for a short
| durration.

That's a good guess.

| Thus spake Randy.Dunlap (rddunlap@osdl.org):
| 
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
| > There's a 2.4.22-pre patch in this dir that you can try:
| >   http://www.xenotime.net/linux/ikconfig/
| > 
| > 
| > --
| > ~Randy
| > MOTD:  Always include version info.
| 
| :wq!
| ---------------------------------------------------------------------------
| Robert L. Harris                     | GPG Key ID: E344DA3B
|                                          @ x-hkp://pgp.mit.edu
| DISCLAIMER:
|       These are MY OPINIONS ALONE.  I speak for no-one else.


--
~Randy
MOTD:  Always include version info.
