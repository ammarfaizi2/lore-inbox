Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263888AbTI2RXg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 13:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263885AbTI2RXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 13:23:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:63888 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263880AbTI2RWr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 13:22:47 -0400
Date: Mon, 29 Sep 2003 10:14:53 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: cijoml@volny.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3C59x module doesn't work in 2.6.0-test6
Message-Id: <20030929101453.18c804dd.rddunlap@osdl.org>
In-Reply-To: <200309281502.38370.cijoml@volny.cz>
References: <200309281502.38370.cijoml@volny.cz>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Sep 2003 15:02:38 +0200 "Michal Semler (volny.cz)" <cijoml@volny.cz> wrote:

| Hi,
| 
| I compiled 2.6.0-test6, but my ethernet card doesn't work:
| 
| modprobe 3c59x tells this:
| Sep 28 10:06:58 tata kernel: 3c59x: Unknown parameter `3c509x'

So 3c59x complains about '3c509x' ??

Did you use any module parameters, either on the modprobe command
or in the /etc/modprobe.conf file?

--
~Randy
