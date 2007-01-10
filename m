Return-Path: <linux-kernel-owner+w=401wt.eu-S932801AbXAJMtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932801AbXAJMtg (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 07:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932799AbXAJMtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 07:49:36 -0500
Received: from stinky.trash.net ([213.144.137.162]:34034 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932801AbXAJMtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 07:49:36 -0500
Message-ID: <45A4E0DE.9010209@trash.net>
Date: Wed, 10 Jan 2007 13:49:34 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Starvik <mikael.starvik@axis.com>
CC: "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       Edgar Iglesias <edgar.iglesias@axis.com>,
       "'Netfilter Development Mailinglist'" 
	<netfilter-devel@lists.netfilter.org>
Subject: Re: Iptable loop during kernel startup
References: <BFECAF9E178F144FAEF2BF4CE739C668030B5907@exmail1.se.axis.com>
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C668030B5907@exmail1.se.axis.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Starvik wrote:
>>Which iptables/kernel versions are you using?
> 
> 
> 2.6.19. After further testing it seams to be a compiler/CPU issue. The exact
> 
> same kernelconfig works on ARM. So I have to dig some...

On which architecture did the error occur? It could be related
to 32 bit compat issues ..


