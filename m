Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbTJCWUH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 18:20:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbTJCWUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 18:20:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:45952 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261277AbTJCWUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 18:20:04 -0400
Date: Fri, 3 Oct 2003 15:11:32 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] if(foo) BUG() -> BUG_ON(foo) for include/arch/
Message-Id: <20031003151132.6c6826df.rddunlap@osdl.org>
In-Reply-To: <200309241252.54097@bilbo.math.uni-mannheim.de>
References: <200309241233.09877@bilbo.math.uni-mannheim.de>
	<200309241234.58125@bilbo.math.uni-mannheim.de>
	<200309241236.31384@bilbo.math.uni-mannheim.de>
	<200309241252.54097@bilbo.math.uni-mannheim.de>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Sep 2003 12:52:54 +0200 Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:

| Ok, last one. I'm too lazy to look who is responsible for each
| part, so see it as FYI. If someone feels responsible for parts of this just
| copy the relevant parts to the arch maintainers.

or you could submit your 4 patch files either via
http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/
to the Trivial Patch Monkey (trivial at rustcorp.com.au)

or to the kernel-janitors project:
(http://www.kerneljanitors.org/)
to kernel-janitors@osdl.org

--
~Randy
