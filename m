Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265169AbUAOQeU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 11:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265170AbUAOQeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 11:34:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:52614 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265169AbUAOQeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 11:34:18 -0500
Date: Thu, 15 Jan 2004 08:30:50 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: rusty@rustcorp.com.au
Subject: Re: modprobe failed: digest_null
Message-Id: <20040115083050.333bb13d.rddunlap@osdl.org>
In-Reply-To: <20040115080815.GA2806@piper.madduck.net>
References: <20040113215355.GA3882@piper.madduck.net>
	<20040115102231.37a84ed0.rusty@rustcorp.com.au>
	<20040115080815.GA2806@piper.madduck.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jan 2004 09:08:15 +0100 martin f krafft <madduck@madduck.net> wrote:

| also sprach Rusty Russell <rusty@rustcorp.com.au> [2004.01.15.0022 +0100]:
| > Upgrade module-init-tools to 0.9.14 or one of the 3.0 -pres.
| 
| diamond:~# modprobe -V
| module-init-tools version 3.0-pre5

Yes, and I'm using 0.9.14 and seeing similar messages.

--
~Randy
