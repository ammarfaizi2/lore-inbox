Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbVFIGMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbVFIGMR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 02:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262292AbVFIGLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 02:11:10 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:24466
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262289AbVFIGK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 02:10:58 -0400
Date: Wed, 08 Jun 2005 23:10:45 -0700 (PDT)
Message-Id: <20050608.231045.48808548.davem@davemloft.net>
To: vda@ilport.com.ua
Cc: jketreno@linux.intel.com, pavel@ucw.cz, jgarzik@pobox.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw2100: firmware problem
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200506090903.49295.vda@ilport.com.ua>
References: <42A7268D.9020402@linux.intel.com>
	<20050608.124332.85408883.davem@davemloft.net>
	<200506090903.49295.vda@ilport.com.ua>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Vlasenko <vda@ilport.com.ua>
Date: Thu, 9 Jun 2005 09:03:49 +0300

> You practically cannot avoid having initrd because you are very likely
> to need to do some wifi config (at least ESSID and mode).

I need neither at home.  It comes up by default just fine with
ifconfig.

Your points are valid, but they do not detract from the fact that
pieced up drivers, half in the kernel half somewhere else, is total
madness.  It is a lose for the user.
