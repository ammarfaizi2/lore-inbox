Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753206AbVHHB3C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753206AbVHHB3C (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 21:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753207AbVHHB3C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 21:29:02 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:35973
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1753206AbVHHB3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 21:29:01 -0400
Subject: Re: Wireless support
From: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
Reply-To: abonilla@linuxwireless.org
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1123464052.15269.4.camel@mindpipe>
References: <1123442554.12766.17.camel@mindpipe>
	 <1123461574.4920.6.camel@localhost.localdomain>
	 <1123464052.15269.4.camel@mindpipe>
Content-Type: text/plain
Date: Sun, 07 Aug 2005 19:29:03 -0600
Message-Id: <1123464543.4920.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-07 at 21:20 -0400, Lee Revell wrote:
> On Sun, 2005-08-07 at 18:39 -0600, Alejandro Bonilla Beeche wrote:
> > On Sun, 2005-08-07 at 15:22 -0400, Lee Revell wrote:
> > > Is the Linksys WUSB 54GS wireless adapter (FCCID Q87-WUSB54GS)
> > > supported?
> > > 
> > > TIA,
> > > 
> > > Lee
> > 
> > Normally, linksys doesn't care much about Linux and they won't even
> > release info for a driver. Yeah, they have some open info for the WRT's
> > but the adapters are normally usable with ndiswrapper or Linuxant
> > driver.
> > 
> > IMHO, in reference to Wireless adapters, I would get already supported
> > ones.
> 
> Well, AFAICT it should be supported by the prism54 driver.  Is this not
> the case?

http://linuxwifi.com/modules/wiwimod/?page=DeviceList

Apparently, looks like only the WUSB54G not the WUSB54GS. But that makes
me think that it should be supported soon by the prism54.

Maybe ask them if they have a clue, or if they have an experimental
patch to support it?

> Lee


