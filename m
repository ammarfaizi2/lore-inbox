Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751358AbWAKLFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbWAKLFU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 06:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWAKLFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 06:05:19 -0500
Received: from aun.it.uu.se ([130.238.12.36]:51950 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1751358AbWAKLFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 06:05:18 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17348.58532.375242.210475@alkaid.it.uu.se>
Date: Wed, 11 Jan 2006 11:57:40 +0100
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Marcin Dalecki <dalecki.marcin@neostrada.pl>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ftape: remove some outdated information from Kconfig files
In-Reply-To: <52078AC1-B781-4664-A03A-1DC84C84490B@neostrada.pl>
References: <20060110205709.GE3911@stusta.de>
	<52078AC1-B781-4664-A03A-1DC84C84490B@neostrada.pl>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Dalecki writes:
 > 
 > On 2006-01-10, at 21:57, Adrian Bunk wrote:
 > 
 > > This patch removes some outdated information about the ftape driver  
 > > like
 > > pointers to no longer existing webpages from Kconfig files.
 > 
 > You could just remove this driver completely as well. Because  
 > practically since
 > it's inclusion in to the main stream kernel it has been outdated and  
 > nonfunctioning.

There exists configurations for which it does work.

 > 4. Right now the corresponding user space tools can't be found on the  
 > web any longer.

The only required tools are standard things like mt and tar or cpio.
The tape formatting tools are out in the wild somewhere, big deal.

Or are you volunteering to take over maintenance of ftape-4.x and merge
that into the kernel?
