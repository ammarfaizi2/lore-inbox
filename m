Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750834AbVIFTs5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834AbVIFTs5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 15:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbVIFTs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 15:48:57 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:48342 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1750834AbVIFTs5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 15:48:57 -0400
Date: Tue, 6 Sep 2005 21:46:02 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Miroslaw Mieszczak <mieszcz@zabrze.zigzag.pl>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Patch for link detection for R8169
Message-ID: <20050906194602.GA20862@electric-eye.fr.zoreil.com>
References: <431DA887.2010008@zabrze.zigzag.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <431DA887.2010008@zabrze.zigzag.pl>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miroslaw Mieszczak <mieszcz@zabrze.zigzag.pl> :
> There is a patch to driver of RLT8169 network card. This match make 
> possible detection of the link status even if network interface is down.
> This is usefull for laptop users.

(side note: there is maintainer entry for the r8169 and network related
patches are welcome on netdev@vger.kernel.org)

Can you elaborate why it is usefull for laptop users ?

I am sceptical: tg3/bn2x/skge do not seem to allow it either.

Jeff, is it a requirement ?

--
Ueimor
