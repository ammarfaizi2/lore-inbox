Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753191AbVHHBUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753191AbVHHBUz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 21:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753196AbVHHBUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 21:20:55 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:33463 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1753191AbVHHBUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 21:20:54 -0400
Subject: Re: Wireless support
From: Lee Revell <rlrevell@joe-job.com>
To: abonilla@linuxwireless.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1123461574.4920.6.camel@localhost.localdomain>
References: <1123442554.12766.17.camel@mindpipe>
	 <1123461574.4920.6.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sun, 07 Aug 2005 21:20:52 -0400
Message-Id: <1123464052.15269.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-07 at 18:39 -0600, Alejandro Bonilla Beeche wrote:
> On Sun, 2005-08-07 at 15:22 -0400, Lee Revell wrote:
> > Is the Linksys WUSB 54GS wireless adapter (FCCID Q87-WUSB54GS)
> > supported?
> > 
> > TIA,
> > 
> > Lee
> 
> Normally, linksys doesn't care much about Linux and they won't even
> release info for a driver. Yeah, they have some open info for the WRT's
> but the adapters are normally usable with ndiswrapper or Linuxant
> driver.
> 
> IMHO, in reference to Wireless adapters, I would get already supported
> ones.

Well, AFAICT it should be supported by the prism54 driver.  Is this not
the case?

Lee

