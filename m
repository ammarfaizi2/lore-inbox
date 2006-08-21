Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751236AbWHUWE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbWHUWE4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 18:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbWHUWE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 18:04:56 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:41446
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751231AbWHUWEz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 18:04:55 -0400
Date: Mon, 21 Aug 2006 15:05:09 -0700 (PDT)
Message-Id: <20060821.150509.111198790.davem@davemloft.net>
To: shemminger@osdl.org
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, akpm@osdl.org, jklewis@us.ibm.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org, jgarzik@pobox.com,
       Jens.Osterkamp@de.ibm.com, linas@austin.ibm.com, corbet@lwn.net
Subject: Re: NAPI documentation
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060821134053.7225987b@dxpl.pdx.osdl.net>
References: <200608191325.19557.arnd@arndb.de>
	<200608201948.20596.arnd@arndb.de>
	<20060821134053.7225987b@dxpl.pdx.osdl.net>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Hemminger <shemminger@osdl.org>
Date: Mon, 21 Aug 2006 13:40:53 -0700

> Please edit and improve
> 	http://linux-net.osdl.org/index.php/NAPI
> 
> When the page is in good shape, I will de-wiki it to place in kernel doc tree.

How do I edit the introduction paragraphs at the top?  I want to edit
this sentence since it sounds awful:

	NAPI ("New API") is a modification to the packet process, ...

I want to change "packet process" to something more descriptive
and accurate.

