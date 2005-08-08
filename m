Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbVHHRsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbVHHRsW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 13:48:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVHHRsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 13:48:22 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:30370 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932158AbVHHRsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 13:48:21 -0400
Subject: Re: Wireless support
From: Lee Revell <rlrevell@joe-job.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: abonilla@linuxwireless.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200508080931.59084.vda@ilport.com.ua>
References: <1123442554.12766.17.camel@mindpipe>
	 <1123461574.4920.6.camel@localhost.localdomain>
	 <200508080931.59084.vda@ilport.com.ua>
Content-Type: text/plain
Date: Mon, 08 Aug 2005 13:48:17 -0400
Message-Id: <1123523298.15269.18.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-08-08 at 09:31 +0300, Denis Vlasenko wrote:
> On Monday 08 August 2005 03:39, Alejandro Bonilla Beeche wrote:
> > On Sun, 2005-08-07 at 15:22 -0400, Lee Revell wrote:
> > > Is the Linksys WUSB 54GS wireless adapter (FCCID Q87-WUSB54GS)
> > > supported?
> > 
> > Normally, linksys doesn't care much about Linux and they won't even
> > release info for a driver. Yeah, they have some open info for the WRT's
> > but the adapters are normally usable with ndiswrapper or Linuxant
> > driver.
> 
> The more I read this, the more I think about usefulness of blacklisting
> ndiswrapper.

What's your reasoning?  The technical aspect of the argument is obvious
(incompatible with 4K stacks) but the political side seems insolvable.
Wouldn't this leave thousands of users with non working hardware?

Lee 

