Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314551AbSG2Khh>; Mon, 29 Jul 2002 06:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314553AbSG2Khh>; Mon, 29 Jul 2002 06:37:37 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:16631 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314551AbSG2Khh>; Mon, 29 Jul 2002 06:37:37 -0400
Subject: Re: cli/sti removal from linux-2.5.29/drivers/ide?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, martin@dalecki.de
In-Reply-To: <200207290026.RAA00298@baldur.yggdrasil.com>
References: <200207290026.RAA00298@baldur.yggdrasil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 Jul 2002 12:56:29 +0100
Message-Id: <1027943789.842.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 01:26, Adam J. Richter wrote:
> 	I have not seen any new IDE patches on lkml since 2.5.29 was
> released, nor have I seen any other IDE patches that fix this.  Sorry
> if I missed a message about it.

I've been through them and I have a set but I've not been able to verify
they are correct as they relate to vesa/eisa/isa stuff I don't posess.

Martin - is the host lock held when the tuning function is called ?

