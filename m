Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932370AbWBXBRm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbWBXBRm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 20:17:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWBXBRm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 20:17:42 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:28579
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932346AbWBXBRl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 20:17:41 -0500
Date: Thu, 23 Feb 2006 17:17:46 -0800 (PST)
Message-Id: <20060223.171746.81607534.davem@davemloft.net>
To: lcapitulino@mandriva.com.br
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       robert.olsson@its.uu.se
Subject: Re: [PATCH 00/01] pktgen: Lindent run.
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060123134419.efc0c80e.lcapitulino@mandriva.com.br>
References: <20060123134419.efc0c80e.lcapitulino@mandriva.com.br>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>
Date: Mon, 23 Jan 2006 13:44:19 -0200

> 
>  This patch is not in-lined because it's 120K bytes long, you can found it at:
> 
> http://www.cpu.eti.br/patches/pktgen_lindent_1.patch

Not found:

davem@sunset:~/src/GIT/net-2.6.17$ wget http://www.cpu.eti.br/patches/pktgen_lindent_1.patch
--17:16:50--  http://www.cpu.eti.br/patches/pktgen_lindent_1.patch
           => `pktgen_lindent_1.patch'
Resolving www.cpu.eti.br... 209.59.143.183
Connecting to www.cpu.eti.br|209.59.143.183|:80... connected.
HTTP request sent, awaiting response... 404 Not Found
17:16:50 ERROR 404: Not Found.

Anyways, can you please regenerate these 4 patches against
net-2.6.17, as I put in Arthur's race fix and it will certainly
conflict with these.

Sorry for taking so long to get to this :-(
