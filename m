Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262050AbTLHXBl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 18:01:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTLHXBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 18:01:41 -0500
Received: from fw.osdl.org ([65.172.181.6]:33497 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262050AbTLHXBj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 18:01:39 -0500
Date: Mon, 8 Dec 2003 14:53:47 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: mru@kth.se (=?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?=), Matthieu.Moy@imag.fr
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: BTTV option not available in make gconfig
Message-Id: <20031208145347.10db1b52.rddunlap@osdl.org>
In-Reply-To: <yw1xzne2aphn.fsf@kth.se>
References: <vpq1xrfnd49.fsf@ecrins.imag.fr>
	<yw1xzne2aphn.fsf@kth.se>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Dec 2003 23:55:48 +0100 mru@kth.se (Måns Rullgård) wrote:

| Matthieu Moy <Matthieu.Moy@imag.fr> writes:
| 
| > I'm upgrading my kernel to 2.6-test9
| 
| Why not -test11 while you're at it?
| 
| > The option CONFIG_VIDEO_BT848=m in .config was available in 2.4, but I
| > can't find in  doing a "make gconfig" in the new  version. (This is to
| > manage my Pinnacle PCTV card)
| 
| Say Y or M to I2O support.

I2C instead of I2O ???

--
~Randy
MOTD:  Always include version info.
