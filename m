Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271407AbTG2Lv5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 07:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271410AbTG2Lv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 07:51:57 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:22757 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S271407AbTG2Lvy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 07:51:54 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Wakko Warner <wakko@animx.eu.org>
Date: Tue, 29 Jul 2003 13:51:28 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: matroxfb and 2.6.0-test2
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <89B099B2CBF@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Jul 03 at 7:27, Wakko Warner wrote:

> I have an old matrox millenium 1 card.  does the matrox fb support this
> card?  All I got was a blank screen.  fbcon and matroxfb with support for
> I/II cards compiled in.  When I had vga16 compiled in as well, I would get the
> console if I switched to vt2 and back to vt1.

Yes, it supports Millennium1 too. Are you sure that you built fbcon
support into the kernel? And that you have only one fbdev, matroxfb?
>From your description it looks to me like that you are using vesafb
together with matroxfb.
                                                    Petr
                                                    

