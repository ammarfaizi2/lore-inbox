Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTLSQwq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 11:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTLSQwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 11:52:46 -0500
Received: from fw.osdl.org ([65.172.181.6]:36314 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263464AbTLSQwp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 11:52:45 -0500
Date: Fri, 19 Dec 2003 08:51:26 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Lenar =?ISO-8859-1?Q?L=F5hmus?= <lenar@city.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 fails to complete boot - Sony VAIO laptop
Message-Id: <20031219085126.6e13bb43.rddunlap@osdl.org>
In-Reply-To: <20031219135316.42DE41FFFF@xs.dev>
References: <14q3A-5qF-11@gated-at.bofh.it>
	<14qd7-5Fl-1@gated-at.bofh.it>
	<20031219135316.42DE41FFFF@xs.dev>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Dec 2003 15:53:15 +0200 Lenar Lõhmus <lenar@city.ee> wrote:

| > Okay, nothing matching other bugreports turned up here. I might have
| > to ask you to try to capture some log information. Do you have a null
| > modem cable or a null modem adapter and serial cable, and another box
| > to hook that up to?
| 
| Could somebody please forward port kmsgdump? It's at 
| http://w.ods.org/tools/kmsgdump/ but the link to 2.5 patches is not
| functional anymore. It would be really great for those without null-modem
| cables.

http://developer.osdl.org/rddunlap/kmsgdump/

I think that the 260test9c patch still works.
I'll check and update it if needed.

--
~Randy
MOTD:  Always include version info.
