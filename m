Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWCaNgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWCaNgO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 08:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWCaNgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 08:36:14 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:36314 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S932136AbWCaNgN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 08:36:13 -0500
Date: Fri, 31 Mar 2006 23:36:12 +1000
From: David McCullough <david_mccullough@au.securecomputing.com>
To: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: ocf-linux-20060331 - Asynchronous Crypto support for linux
Message-ID: <20060331133612.GB23729@beast>
References: <20060301042632.GA17290@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301042632.GA17290@beast>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

A new release of the ocf-linux package is up:

	http://ocf-linux.sourceforge.net/

The changes from the previous release:

	* New Freescale Talitos Driver contributed by Kim Phillips
	* Fixups for some 64bit OS support issues
	* Correctly address safenet lockups on rev 1.0 chips
	* updated openswan patch to 2.4.5rc6

Tested under 2.4.32 and 2.6.16 across multiple architectures,

Cheers,
Davidm

-- 
David McCullough,  david_mccullough@securecomputing.com,   Ph:+61 734352815
Secure Computing - SnapGear  http://www.uCdot.org http://www.cyberguard.com
