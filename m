Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265282AbUGCXTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265282AbUGCXTz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 19:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265287AbUGCXTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 19:19:55 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:50106 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S265282AbUGCXTx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 19:19:53 -0400
Date: Sun, 4 Jul 2004 01:11:42 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: jt@hpl.hp.com
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       David Gibson <hermes@gibson.dropbear.id.au>
Subject: Re: [PATCH] Update in-kernel orinoco drivers to upstream current CVS
Message-ID: <20040704011142.C3275@electric-eye.fr.zoreil.com>
References: <20040702222655.GA10333@bougret.hpl.hp.com> <20040703010709.A22334@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040703010709.A22334@electric-eye.fr.zoreil.com>; from romieu@fr.zoreil.com on Sat, Jul 03, 2004 at 01:07:09AM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu <romieu@fr.zoreil.com> :
[...]
> -rw-r--r--    1 romieu   users        4564 jui  3 00:47 orinoco-10.patch
> -rw-r--r--    1 romieu   users       15999 jui  3 00:47 orinoco-20.patch
> -rw-r--r--    1 romieu   users       33135 jui  3 00:47 orinoco-30.patch
> -rw-r--r--    1 romieu   users       11463 jui  3 00:47 orinoco-40.patch

Updated to:
-rw-r--r--    1 romieu   users        5111 jui  4 01:02 orinoco-10.patch
-rw-r--r--    1 romieu   users       15999 jui  4 01:02 orinoco-20.patch
-rw-r--r--    1 romieu   users       33135 jui  4 01:02 orinoco-30.patch
-rw-r--r--    1 romieu   users       11463 jui  4 01:02 orinoco-40.patch
-rw-r--r--    1 romieu   users       10414 jui  4 01:02 orinoco-50.patch
-rw-r--r--    1 romieu   users        1515 jui  4 01:02 orinoco-60.patch
-rw-r--r--    1 romieu   users        5499 jui  4 01:02 orinoco-70.patch
-rw-r--r--    1 romieu   users        8907 jui  4 01:02 orinoco-80.patch
-rw-r--r--    1 romieu   users        4800 jui  4 01:02 orinoco-90.patch
-rw-r--r--    1 romieu   users        2185 jui  4 01:02 orinoco-100.patch
-rw-r--r--    1 romieu   users        1907 jui  4 01:02 orinoco-110.patch
-rw-r--r--    1 romieu   users        1639 jui  4 01:02 orinoco-120.patch
-rw-r--r--    1 romieu   users        6721 jui  4 01:02 orinoco-130.patch
-rw-r--r--    1 romieu   users        2647 jui  4 01:02 orinoco-140.patch

Still available at http://www.fr.zoreil.com/linux/kernel/2.6.x/2.6.7-mm5/

An extra netdev_priv() has been added to orinoco-10.patch.

--
Ueimor
