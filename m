Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262903AbTELW7M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 18:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbTELW7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 18:59:11 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:2451 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262903AbTELW7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 18:59:10 -0400
Subject: Re: PCMCIA 2.5.X sleeping from illegal context
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Fulghum <paulkf@microgate.com>,
       David Hinds <dahinds@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1052773631.31825.18.camel@dhcp22.swansea.linux.org.uk>
References: <1052775331.1995.49.camel@diemos>
	 <1052773631.31825.18.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain
Message-Id: <1052781069.1185.0.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 13 May 2003 01:11:09 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-12 at 23:07, Alan Cox wrote:
> On Llu, 2003-05-12 at 22:35, Paul Fulghum wrote:
> > The 2.5.X PCMCIA kernel support seems to have a problem
> > with drivers/pcmcia/rsrc_mgr.c in function undo_irq().
> 
> Does this still happen with all the patches Russell King posted
> that everyone else is ignoring ?

Not everybody is ignoring them ;-)

