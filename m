Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263941AbUD3GNN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263941AbUD3GNN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 02:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265065AbUD3GNN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 02:13:13 -0400
Received: from fep02-mail.bloor.is.net.cable.rogers.com ([66.185.86.72]:50980
	"EHLO fep02-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S263941AbUD3GNJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 02:13:09 -0400
Date: Fri, 30 Apr 2004 02:13:05 -0400
From: Sean Estabrooks <seanlkml@rogers.com>
To: Marc Boucher <marc@linuxant.com>
Cc: koke@sindominio.net, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       riel@redhat.com, david@gibson.dropbear.id.au, torvalds@osdl.org,
       miller@techsource.com, paul@wagland.net
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-Id: <20040430021305.6814f29e.seanlkml@rogers.com>
In-Reply-To: <6FD0ADAF-9A69-11D8-B83D-000A95BCAC26@linuxant.com>
References: <Pine.LNX.4.44.0404291114150.9152-100000@chimarrao.boston.redhat.com>
	<4FE43C97-9A20-11D8-B804-000A95CD704C@wagland.net>
	<4091757B.3090209@techsource.com>
	<200404292347.17431.koke_lkml@amedias.org>
	<0CAE0144-9A2C-11D8-B83D-000A95BCAC26@linuxant.com>
	<20040429195553.4fba0da7.seanlkml@rogers.com>
	<3A39091E-9A4C-11D8-B83D-000A95BCAC26@linuxant.com>
	<20040430004344.663acf90.seanlkml@rogers.com>
	<6FD0ADAF-9A69-11D8-B83D-000A95BCAC26@linuxant.com>
Organization: 
X-Mailer: Sylpheed version 0.9.9-gtk2-20040229 (GTK+ 2.2.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep02-mail.bloor.is.net.cable.rogers.com from [24.103.219.176] using ID <seanlkml@rogers.com> at Fri, 30 Apr 2004 02:12:16 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Apr 2004 01:44:24 -0400
Marc Boucher <marc@linuxant.com> wrote:

> There are major chipset vendors out there who have managed to become 
> market leaders while not providing any drivers for Linux.
> 
> But other vendors are also still releasing new native linux drivers, 
> despite the availability of our solutions (Intel's project for Centrino 
> 
> This essentially proves that we are not removing the incentive to do 
> proper native drivers, simply providing more options for 1) people who 
> would otherwise be stuck or unable to use the full functionality of 
> their machines under Linux right now, and 2) vendors who are not able 
> to afford or justify the cost of developing native linux drivers due to 
> the size of the current Linux desktop market. In general these vendors 
> plan to one day produce native drivers, once the numbers make it 
> possible.

That's not how you pitch it on your website.  For instance, how many
sales does Intel's Centrino project lose because you make non GPL-friendly
hardware viable under Linux?   Anyway, no matter how sure you are of
your position, it doesn't justify what you did.

Sean.
