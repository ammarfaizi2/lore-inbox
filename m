Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262540AbVEMUgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbVEMUgS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 16:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVEMUfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 16:35:30 -0400
Received: from main.gmane.org ([80.91.229.2]:13734 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262540AbVEMU3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 16:29:23 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andres Salomon <dilinger@athenacr.com>
Subject: Re: Status of net/ipv4/ipvs/ip_vs_proto_icmp.c?
Date: Fri, 13 May 2005 15:09:01 -0400
Message-ID: <pan.2005.05.13.19.09.00.598647@athenacr.com>
References: <20050513041622.GE3603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 66.150.84.1
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table (Debian GNU/Linux))
Cc: netdev@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 May 2005 06:16:22 +0200, Adrian Bunk wrote:

> Hi,
> 
> can anyone explain the status of?
> 
> This file is always included in the kernel if CONFIG_IP_VS=y, but it's 
> completely unused.
> 
> Will it be made working in the forseeable future or is it a candidate 
> for removal?
> 
> TIA
> Adrian

The people/places to ask would probably be:

IPVS
P:      Wensong Zhang
M:      wensong@linux-vs.org
P:      Julian Anastasov
M:      ja@ssi.bg
S:      Maintained

or

http://www.linuxvirtualserver.org/mailing.html


