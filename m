Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265532AbUBAWof (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 17:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265533AbUBAWof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 17:44:35 -0500
Received: from mail008.syd.optusnet.com.au ([211.29.132.212]:43495 "EHLO
	mail008.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265532AbUBAWod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 17:44:33 -0500
From: Christian Unger <chakkerz@optusnet.com.au>
Reply-To: chakkerz@optusnet.com.au
Organization: naiv.sourceforge.net
To: Geert Uytterhoeven <geert@linux-m68k.org>,
       Timothy Miller <miller@techsource.com>
Subject: Re: [OT] Crazy idea:  Design open-source graphics chip
Date: Mon, 2 Feb 2004 09:41:22 +1100
User-Agent: KMail/1.5.4
Cc: John Bradford <john@grabjohn.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4017F2C0.4020001@techsource.com> <40195AE0.2010006@techsource.com> <Pine.GSO.4.58.0402011123010.20933@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0402011123010.20933@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402020941.22607.chakkerz@optusnet.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Ok, so, how about this idea:
> >
> > - Small Xilinx FPGA, 16M of RAM, and a DAC on a board.
> > - AGP 2X
> > - Up to 2048x2048 resolution at 8, 16, and 32 bpp.
> > - Acceleration ONLY for solid fills and bitblts on-screen.
>
> Sounds OK to me.

Disregarding what i said 5 min ago on modular RAM (sorry ... delusions of 
grandure).

Would it have to be AGP? afteall the data volumes pumping through that would 
probably be not that high, and with the PCI express being backwards 
compatible, this would evade a dying bus.
-- 
with kind regards,
  Christian Unger

-<< Contact Details >>- < > - < > - < > - < > - < > -<< Naiv Status >>- < > -

  Alt. Email:  chakkerz_dev@optusnet.com.au      |   Stable:    0.2.3 r3
  ICQ:         204184156                         |   Latest:    0.3.0
  Mobile:      0402 268904                       |   Current:   0.3.1
  Web:         http://naiv.sourceforge.net       |   Focus:     File Handling

  "You don't need eyes to see ... You need vision" (Faithless - Revenrence)

