Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281411AbRKUBaL>; Tue, 20 Nov 2001 20:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281554AbRKUBaC>; Tue, 20 Nov 2001 20:30:02 -0500
Received: from chac.inf.utfsm.cl ([200.1.19.54]:38405 "EHLO chac.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id <S281411AbRKUB35>;
	Tue, 20 Nov 2001 20:29:57 -0500
Message-Id: <200111210122.fAL1MwhC029913@sleipnir.valparaiso.cl>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Steffen Persvold <sp@scali.no>,
        Christopher Friesen <cfriesen@nortelnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: NFS, Paging & Installing [was: Re: Swap] 
In-Reply-To: Your message of "Tue, 20 Nov 2001 13:50:59 -0800."
             <20011120135059.D4210@mikef-linux.matchmail.com> 
X-mailer: MH [Version 6.8.4]
X-charset: ISO_8859-1
Date: Tue, 20 Nov 2001 22:22:58 -0300
From: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> said:
> Do any newer versions of NFS fix the stateless server problem?

This is an _extremely_ hard problem: The server has to know somehow what
the client thinks the state is... and either one (or both) may have been
rebooted in between without the other one knowing.
-- 
Horst von Brand                             vonbrand@sleipnir.valparaiso.cl
Casilla 9G, Vin~a del Mar, Chile                               +56 32 672616
