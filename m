Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270724AbTG1Upr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 16:45:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271094AbTG1UpL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 16:45:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:34271 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271036AbTG1UoN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 16:44:13 -0400
Date: Mon, 28 Jul 2003 13:41:28 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Balram Adlakha <b_adlakha@softhome.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2 OSS emu10k1
Message-Id: <20030728134128.50dcd71e.rddunlap@osdl.org>
In-Reply-To: <20030727190257.GA2840@localhost.localdomain>
References: <20030727190257.GA2840@localhost.localdomain>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jul 2003 00:32:57 +0530 Balram Adlakha <b_adlakha@softhome.net> wrote:

| I cannot compile the emu10k1 module:
| 
| sound/oss/emu10k1/hwaccess.c:182: redefinition of `emu10k1_writefn0_2'
| sound/oss/emu10k1/hwaccess.c:164: `emu10k1_writefn0_2' previously defined here
| make[3]: *** [sound/oss/emu10k1/hwaccess.o] Error 1
| make[2]: *** [sound/oss/emu10k1] Error 2
| make[1]: *** [sound/oss] Error 2
| make: *** [sound] Error 2
| 
| 
| Everything else looks fine till now...
| -

I don't see this problem when I build it.
Could it be a source file (or download) problem?
or a tools problem?

--
~Randy
