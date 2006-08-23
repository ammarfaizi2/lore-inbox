Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965261AbWHWWbk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965261AbWHWWbk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 18:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965246AbWHWWbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 18:31:39 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:7810 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S965258AbWHWWbj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 18:31:39 -0400
Date: Thu, 24 Aug 2006 00:30:32 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: penberg@cs.Helsinki.FI, akpm@osdl.org, dvrabel@cantab.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       david@pleyades.net
Subject: Re: [PATCH] IP1000A: IC Plus update 2006-08-22
Message-ID: <20060823223032.GA25111@electric-eye.fr.zoreil.com>
References: <1156268234.3622.1.camel@localhost.localdomain> <20060822232730.GA30977@electric-eye.fr.zoreil.com> <20060823113822.GA17103@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060823113822.GA17103@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> :
[...]
> Typo. It should be:
> http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.18-rc4/ip1000

Added 0038-ip1000-CodingStyle.txt.

More local variables, more unsigned int, less MixedCase, ipg_nic_rx()
fits in your favorite 80 cols console.

-- 
Ueimor
