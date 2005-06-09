Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262288AbVFIGUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbVFIGUm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 02:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVFIGTK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 02:19:10 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:52902
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S262285AbVFIGRK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 02:17:10 -0400
Date: Wed, 08 Jun 2005 23:16:57 -0700 (PDT)
Message-Id: <20050608.231657.59660080.davem@davemloft.net>
To: vda@ilport.com.ua
Cc: abonilla@linuxwireless.org, pavel@ucw.cz, jgarzik@pobox.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw2100: firmware problem
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200506090909.55889.vda@ilport.com.ua>
References: <002901c56c3b$8216cdd0$600cc60a@amer.sykes.com>
	<200506090909.55889.vda@ilport.com.ua>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Denis Vlasenko <vda@ilport.com.ua>
Date: Thu, 9 Jun 2005 09:09:55 +0300

> On Wednesday 08 June 2005 18:05, Alejandro Bonilla wrote:
> > Currently, when we install the driver, it associates to any open network on
> > boot. This is good, cause we don't want to be typing the commands all the
> > time just to associate. It works this way now and is pretty nice.
> 
> What is so nice about this? That Linux novice user with his new lappie
> will join a neighbor's network every time he powers up the lappie,
> even without knowing that?

I love this behavior, because it means that I don't have to do
anything special to get my setup at home working.

Me caveman
Me plug in wireless router
Me watch pretty lights
Me turn on computer
Me up interface
Computer work
Me no care other cavemen use wireless link

Configuration knobs are _madness_.  Things should work with minimal
intervention and configuration.
