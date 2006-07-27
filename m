Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751955AbWG0TLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbWG0TLE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 15:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbWG0TLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 15:11:04 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:46042 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S1751055AbWG0TLC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 15:11:02 -0400
Date: Thu, 27 Jul 2006 21:07:07 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Jesse Huang <jesse@icplus.com.tw>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Hello, We have IP100A Linux driver need to submit to 2.6.x kernel
Message-ID: <20060727190707.GA24157@electric-eye.fr.zoreil.com>
References: <02fb01c6b147$b15b8fc0$4964a8c0@icplus.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02fb01c6b147$b15b8fc0$4964a8c0@icplus.com.tw>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Huang <jesse@icplus.com.tw> :
[...]
> I am IC Plus software engineer. We have IP100A 10/100 fast network adapter
> driver need to submit to Linux 2.6.x kernel. Please tell me who should I
> submit to.
> 
> IP100A's device ID is 0x13f0 0200.

You do not need to do anything:

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1668b19f75cb949f930814a23b74201ad6f76a53

As far as I have checked before forwarding Pedro Alejandro's patch, the
out-of-tree IP100 driver exhibited no significant difference with the
sundance driver.

-- 
Ueimor
