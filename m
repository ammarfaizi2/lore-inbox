Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbTIGRsu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 13:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263388AbTIGRsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 13:48:47 -0400
Received: from amalthea.dnx.de ([193.108.181.146]:15511 "EHLO amalthea.dnx.de")
	by vger.kernel.org with ESMTP id S263375AbTIGRsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 13:48:43 -0400
Date: Sun, 7 Sep 2003 19:48:34 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adrian Bunk <bunk@fs.tum.de>, Robert Schwebel <robert@schwebel.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
Message-ID: <20030907174834.GA482@pengutronix.de>
References: <20030907112813.GQ14436@fs.tum.de> <20030907124251.GC5460@pengutronix.de> <20030907130034.GT14436@fs.tum.de> <1062955895.16972.13.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1062955895.16972.13.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
X-Spam-Score: -5.0 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19w3eG-0003aG-00*fHuc315BE/A*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 06:31:36PM +0100, Alan Cox wrote:
> Geode is just another PC, well at least in software. In hardware its
> rather different and uses a lot of clever magic.

It seems to be similar to the Elan: the core is "just another PC", but
in several places you need to know that you have a Geode so that you can
provide the right tweaks and fixes. 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hornemannstraﬂe 12,  31137 Hildesheim, Germany
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4
