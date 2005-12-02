Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932729AbVLBLpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932729AbVLBLpQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 06:45:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932736AbVLBLpP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 06:45:15 -0500
Received: from smtp4.brturbo.com.br ([200.199.201.180]:17714 "EHLO
	smtp4.brturbo.com.br") by vger.kernel.org with ESMTP
	id S932729AbVLBLpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 06:45:14 -0500
Subject: Re: Linux 2.6.15-rc4
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
To: gcoady@gmail.com
Cc: Linus Torvalds <torvalds@osdl.org>, Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       list linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <862vo198it7molqvq5ign38qmncmjk3bo5@4ax.com>
References: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org>
	 <1133445903.16820.1.camel@localhost>
	 <Pine.LNX.4.64.0512010759571.3099@g5.osdl.org>
	 <6f6293f10512011112m6e50fe0ejf0aa5ba9d09dca1e@mail.gmail.com>
	 <Pine.LNX.4.64.0512011125280.3099@g5.osdl.org>
	 <438F6DFF.2040603@eyal.emu.id.au>
	 <Pine.LNX.4.64.0512011347290.3099@g5.osdl.org>
	 <862vo198it7molqvq5ign38qmncmjk3bo5@4ax.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Fri, 02 Dec 2005 09:45:10 -0200
Message-Id: <1133523910.6842.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2-1mdk 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sex, 2005-12-02 às 10:37 +1100, Grant Coady escreveu:
> On Thu, 1 Dec 2005 13:53:28 -0800 (PST), Linus Torvalds <torvalds@osdl.org> wrote:
> 
> >(There are a couple of in-tree drivers that it would be interesting to 
> >hear about too. In particular, all these files:
> ...
> >	drivers/media/video/zr36120.c

	Grant, you were supposed to fix it [1]. As discussed before, if this is
not maintained anymore, just drop it. 

[1] http://lkml.org/lkml/2005/7/29/302

Cheers, 
Mauro.

