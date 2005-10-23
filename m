Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751445AbVJWKfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbVJWKfW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 06:35:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVJWKfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 06:35:22 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:61859 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751445AbVJWKfW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 06:35:22 -0400
Date: Sun, 23 Oct 2005 12:33:27 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Gaurav Dhiman <gaurav4lkg@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Problem]: accessing Marvell LAN card (sk98lin.ko)
Message-ID: <20051023103327.GA7089@electric-eye.fr.zoreil.com>
References: <1e33f5710510230202q2623ff61w275e2aabac72b0a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e33f5710510230202q2623ff61w275e2aabac72b0a6@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gaurav Dhiman <gaurav4lkg@gmail.com> :
> I have Toshiba M55 325 Laptop, which have Marvell 10/100 Base-TX
> Ethernet card. I think the driver for this is sk98lin.ko, I am also
> successful in loading that (saw lsmod). After loading when I do 'ls
> /proc/net/sk98lin/' , it does not show me anything.

Please specify the kernel version and send an 'lspci -x'.

--
Ueimor
