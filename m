Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVAGA2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVAGA2d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:28:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVAGA0V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:26:21 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:54972 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261235AbVAGAUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:20:40 -0500
Subject: Re: Questions about the CMD640 and RZ1000 bugfix support options
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrey Melnikoff <temnota+news@kmv.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <hcr0b2-ofr.ln1@kenga.kmv.ru>
References: <41D5D206.1040107@mathematica.scientia.net>
	 <1104676209.15004.58.camel@localhost.localdomain>
	 <e0qta2-7jr.ln1@kenga.kmv.ru>
	 <1105025417.17176.222.camel@localhost.localdomain>
	 <hcr0b2-ofr.ln1@kenga.kmv.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105053370.17176.294.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 06 Jan 2005 23:16:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-06 at 22:40, Andrey Melnikoff wrote:
> > They should be enabled by default. 
> Why? This is really _OLD_ and _BUGGY_ chips. As I see in google - it used 
> in Asustek Pentium MB PCI/I-P54SP4 and some Intel mb for Pentium with
> Neptune chipsets. All of this MB - for classic Pentium 75/90/100MHz. 

And the cost to you is .. zero.

> > That makes it safer for default compiles, and their code size is 
> > close to if not nil because it can all be __devinit or __init
> At this time, no modern MB use this buggy chipsets.

And lots of people run old motherboards. The base kernel configuration
by default is a mix between "things everyone wants, things defaulting on
for safety reasons and linus computer"

Alan

