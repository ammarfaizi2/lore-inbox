Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266886AbTAIRbM>; Thu, 9 Jan 2003 12:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266888AbTAIRbM>; Thu, 9 Jan 2003 12:31:12 -0500
Received: from mail.ithnet.com ([217.64.64.8]:30215 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S266886AbTAIRbL>;
	Thu, 9 Jan 2003 12:31:11 -0500
Date: Thu, 9 Jan 2003 18:39:52 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: MB without keyboard controller / USB-only keyboard ?
Message-Id: <20030109183952.6be142fe.skraw@ithnet.com>
In-Reply-To: <1042134121.27796.20.camel@irongate.swansea.linux.org.uk>
References: <20030109114247.211f7072.skraw@ithnet.com>
	<1042134121.27796.20.camel@irongate.swansea.linux.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 09 Jan 2003 17:42:01 +0000
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Thu, 2003-01-09 at 10:42, Stephan von Krawczynski wrote:
> > Hello all,
> > 
> > how do I work with a mb that contains no keyboard controller, but has only
> > USB for keyboard and mouse?
> > While booting the kernel I get:
> > 
> > pc_keyb: controller jammed (0xFF)
> 
> Does your BIOS do keyboard emulation ?

It is Compaq EVO D510. It has merely nothing of interest in the BIOS (no
keyboard emu). As far as I remember it contains an I845 chipset.

-- 
Regards,
Stephan
