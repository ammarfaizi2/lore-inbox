Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132568AbRDWXWC>; Mon, 23 Apr 2001 19:22:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132537AbRDWXUL>; Mon, 23 Apr 2001 19:20:11 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12041 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132561AbRDWXSb>; Mon, 23 Apr 2001 19:18:31 -0400
Subject: Re: i810_audio broken?t
To: jgarzik@mandrakesoft.com (Jeff Garzik)
Date: Tue, 24 Apr 2001 00:20:10 +0100 (BST)
Cc: pawel.worach@mysun.com, chmouel@mandrakesoft.com (Chmouel Boudjnah),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <3AE4B3D5.E026E291@mandrakesoft.com> from "Jeff Garzik" at Apr 23, 2001 06:59:33 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14rpcr-0000lY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you guys running esd with any special arguments?
> 
> esd needs a special argument, -r RATE [iirc], in order to tell esd that
> it is dealing with a locked rate codec.

48Khz esound support was fixed the day I got an i810 board 8). Its the
rate conversions it cant handle
