Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270452AbTHLOfK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 10:35:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270453AbTHLOfK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 10:35:10 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:49301 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270452AbTHLOfH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 10:35:07 -0400
Subject: Re: IDE Hotswap Disks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Johannes Stezenbach <js@convergence.de>
Cc: Flameeyes <dgp85@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030811170448.GC732@convergence.de>
References: <1060615212.13982.15.camel@defiant.flameeyes>
	 <20030811170448.GC732@convergence.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060698661.21160.24.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 Aug 2003 15:31:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-08-11 at 18:04, Johannes Stezenbach wrote:
> The hdparm package includes a script which does that (idectl).
> I used it sporadically with a Thinpad Ultrabay IDE disk and cdrom.

I'm working on adding proper support for this in the 2.4-ac tree at the
moment

