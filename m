Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292730AbSDMR0a>; Sat, 13 Apr 2002 13:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292855AbSDMR03>; Sat, 13 Apr 2002 13:26:29 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15366 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292730AbSDMR03>; Sat, 13 Apr 2002 13:26:29 -0400
Subject: Re: link() security
To: chris@wirex.com (Chris Wright)
Date: Sat, 13 Apr 2002 17:59:54 +0100 (BST)
Cc: xystrus@haxm.com (xystrus), linux-kernel@vger.kernel.org
In-Reply-To: <20020411181524.A1463@figure1.int.wirex.com> from "Chris Wright" at Apr 11, 2002 06:15:24 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16wQsU-0000cb-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> http://openwall.com.  Work based on Solar Designer's Openwall patch has
> been brought forward to more recent 2.4 and 2.5 kernels.  Both the
> following projects implement the Openwall secure link feature:
> 
>   http://grsecurity.net
>   http://lsm.immunix.org
> 
> This can break some applications that make assumptions wrt. link(2)
> (Courier MTA for example).

How practical is it to make this a mount option and to do so cleanly ?
