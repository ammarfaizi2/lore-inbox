Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136622AbREAPLh>; Tue, 1 May 2001 11:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136629AbREAPL1>; Tue, 1 May 2001 11:11:27 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:21769 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136622AbREAPLT>; Tue, 1 May 2001 11:11:19 -0400
Subject: Re: isa_read/write not available on ppc - solution suggestions ??
To: bgerst@didntduck.org (Brian Gerst)
Date: Tue, 1 May 2001 16:14:24 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), mike_phillips@urscorp.com,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <3AEECD51.ABC493CB@didntduck.org> from "Brian Gerst" at May 01, 2001 10:50:57 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14ubr8-0001nf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > for ioremap and are meant for lazy porting
> 
> You meant isa_read* were for lazy porting.  read* require ioremap be
> done before hand, even for ISA.

Indeed I do

