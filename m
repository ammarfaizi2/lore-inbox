Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVFIG3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVFIG3r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 02:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262299AbVFIG3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 02:29:46 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:10720
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262294AbVFIG2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 02:28:33 -0400
Date: Wed, 08 Jun 2005 23:28:18 -0700 (PDT)
Message-Id: <20050608.232818.31644993.davem@davemloft.net>
To: vda@ilport.com.ua
Cc: abonilla@linuxwireless.org, pavel@ucw.cz, jgarzik@pobox.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw2100: firmware problem
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200506090925.07495.vda@ilport.com.ua>
References: <200506090909.55889.vda@ilport.com.ua>
	<20050608.231657.59660080.davem@davemloft.net>
	<200506090925.07495.vda@ilport.com.ua>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Vlasenko <vda@ilport.com.ua>
Date: Thu, 9 Jun 2005 09:25:07 +0300

> You need to up interface? And surely you need ip addr? That's a knob also! :)

There's this thing called DHCP which takes care of this for me.
With IPV6, even less configuration can be necessary.
