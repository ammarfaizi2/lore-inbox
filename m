Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271401AbTG2LMY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 07:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271391AbTG2LMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 07:12:10 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:42633
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S271395AbTG2LLe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 07:11:34 -0400
Date: Tue, 29 Jul 2003 07:27:25 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Re: matroxfb and 2.6.0-test2
Message-ID: <20030729072725.B12426@animx.eu.org>
References: <Pine.LNX.4.56.0307281958410.193@pervalidus.dyndns.org> <20030729021321.GA1282@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <20030729021321.GA1282@vana.vc.cvut.cz>; from Petr Vandrovec on Tue, Jul 29, 2003 at 04:13:21AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > WARNING: /lib/modules/2.6.0-test2/kernel/drivers/video/matrox/matroxfb_crtc2.ko
> > needs unknown symbol matroxfb_enable_irq

I have an old matrox millenium 1 card.  does the matrox fb support this
card?  All I got was a blank screen.  fbcon and matroxfb with support for
I/II cards compiled in.  When I had vga16 compiled in as well, I would get the
console if I switched to vt2 and back to vt1.

I don't know if there's an IRQ being assigned to the card.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
