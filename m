Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266849AbSLUJBb>; Sat, 21 Dec 2002 04:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266852AbSLUJBb>; Sat, 21 Dec 2002 04:01:31 -0500
Received: from MailBox.iNES.RO ([80.86.96.21]:62120 "EHLO MailBox.iNES.RO")
	by vger.kernel.org with ESMTP id <S266849AbSLUJBa>;
	Sat, 21 Dec 2002 04:01:30 -0500
Subject: Re: [PATCH 2.4] : donauboe IrDA driver (resend)
From: Dumitru Ciobarcianu <Dumitru.Ciobarcianu@iNES.RO>
To: jt@hpl.hp.com
Cc: Christian Gennerat <xgen@free.fr>, James McKenzie <james@fishsoup.dhs.org>,
       Christian Gennerat <christian.gennerat@polytechnique.org>,
       Martin Lucina <mato@kotelna.sk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <3E035BD4.9000304@free.fr>
References: <20021219024632.GB1746@bougret.hpl.hp.com>
	 <1040310314.1225.9.camel@localhost.localdomain>
	 <20021219185630.GC6703@bougret.hpl.hp.com>
	 <1040381739.1084.43.camel@localhost.localdomain> <3E035BD4.9000304@free.fr>
Content-Type: text/plain
Organization: iNES Advertising
Message-Id: <1040462191.1641.2.camel@UserFriendly.LNX.RO>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 (1.2.0-1) 
Date: 21 Dec 2002 11:16:31 +0200
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.1(snapshot 20020919) (MailBox.iNES.RO)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Vi, 2002-12-20 at 20:05, Christian Gennerat wrote:
> The test shows that there is a deep misunderstanding of how works
> MIR mode, and chaining blocks for optimization at MIR mode.
> some people say "MIR works" . That is good for them.
> I would prefer to have "#undef USE_MIR"
> 
> So, test is not necessary for every day use. Just put
> options donauboe do_probe=0
> in your /etc/modules.conf

Ok, so wouldn't make sense to make this the default for 2.4 ?

//Cioby



