Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750813AbVKJMhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVKJMhs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 07:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750815AbVKJMhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 07:37:48 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:27027 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S1750813AbVKJMha
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 07:37:30 -0500
Date: Thu, 10 Nov 2005 22:37:20 +1000
From: David McCullough <davidm@snapgear.com>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: ocf-linux-20051110 - Asynchronous Crypto support for linux
Message-ID: <20051110123720.GA28097@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

A new release of the ocf-linux package is up:

	http://ocf-linux.sourceforge.net/

Mostly Openswan updates/cleanups and fixes in this release.

* Patch for the latest OpenSwan to utilise OCF for full IPSEC
  ESP and AH processing.
* Well tested on 2.4.31 and 2.6.14 with OpenSwan.
* Simple single patch to add OCF to 2.4 or 2.6 kernels.
* Fixed broken openssl speed test (Ronen Shitrit)

Cheers,
Davidm

-- 
David McCullough, davidm@cyberguard.com.au, Custom Embedded Solutions + Security
Ph:+61 734352815 Fx:+61 738913630 http://www.uCdot.org http://www.cyberguard.com
