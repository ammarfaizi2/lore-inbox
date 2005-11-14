Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751244AbVKNTRp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbVKNTRp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 14:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbVKNTRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 14:17:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64746 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751244AbVKNTRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 14:17:44 -0500
Date: Mon, 14 Nov 2005 11:17:20 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjan@infradead.org>
cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
In-Reply-To: <1131992968.2821.50.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.64.0511141116180.3263@g5.osdl.org>
References: <20051114133802.38755.qmail@web50205.mail.yahoo.com> 
 <200511141802.45788.s0348365@sms.ed.ac.uk>  <20051114181854.GB3652@redhat.com>
  <200511141822.31315.s0348365@sms.ed.ac.uk> <1131992968.2821.50.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Nov 2005, Arjan van de Ven wrote:
> 
> there now is a specification for the broadcom wireless, and a driver is
> being written right now to that specification; and it seems to be
> getting along quite well (it's not ready for primetime use yet but at
> least they can send and receive stuff, which is probably the hardest
> part)

Goodie. With Broadcom and Intel on-board, we should have most of the 
market covered in wireless, and ndiswrappers really should be less of an 
argument (it was never an argument for me personally, but for others..). 

		Linus
