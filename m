Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbVIZAPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbVIZAPE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 20:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751577AbVIZAPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 20:15:03 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:28838 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S1750833AbVIZAPA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 20:15:00 -0400
Date: Mon, 26 Sep 2005 10:14:59 +1000
From: David McCullough <davidm@snapgear.com>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: ocf-linux-20050922 - Asynchronous Crypto support for linux
Message-ID: <20050926001459.GE10157@beast>
References: <20050520135723.GB26883@beast> <20050630134806.GA30067@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050630134806.GA30067@beast>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

A new release of the ocf-linux package is up:

	http://ocf-linux.sourceforge.net/

Mostly fixes in this release.  I had been sitting on sme tof this for
too long.  Best to check the Changelog below for some of the specifics.

At least some 2.6 testing was done for this release :-)

Changes:

* Much improved 2.6 support in OCF
* Openswan patch has full ESP/AH acceleration
* Updated crypto-tools with many fixes/additions
* Much more reliable (will not exhaust system resources under heavy load)

Cheers,
Davidm

-- 
David McCullough, davidm@cyberguard.com.au, Custom Embedded Solutions + Security
Ph:+61 734352815 Fx:+61 738913630 http://www.uCdot.org http://www.cyberguard.com
