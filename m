Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVCKUaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVCKUaD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 15:30:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261302AbVCKU1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 15:27:53 -0500
Received: from mail58-s.fg.online.no ([148.122.161.58]:6045 "EHLO
	mail58-s.fg.online.no") by vger.kernel.org with ESMTP
	id S261804AbVCKUKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 15:10:41 -0500
From: Kenneth =?iso-8859-1?q?Aafl=F8y?= <lists@kenneth.aafloy.net>
To: Juri Haberland <juri@koschikode.com>
Subject: Re: linux dvb alps_tdlb7 removed
Date: Fri, 11 Mar 2005 21:10:27 +0100
User-Agent: KMail/1.7.2
Cc: Peter Waechtler <pwaechtler@mac.com>, linux-kernel@vger.kernel.org
References: <20050311125836.BDB721B02B@nx-01.home.sapienti-sat.org>
In-Reply-To: <20050311125836.BDB721B02B@nx-01.home.sapienti-sat.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503112110.28060.lists@kenneth.aafloy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 March 2005 13:58, Juri Haberland wrote:
> In article <aebc44b2e0c42cc9dc0ec0b215c10ec4@mac.com> you wrote:
> > With version 2.6.10 the driver for the tuner frontend from ALPS TDLB7 
> > was removed.
> > 
> > Why do you think that this is a dead file?
> > While I'm happy with the work you do for dvb on Linux, and I want to 
> > thank you for this anyway, my TV does not work anymore! :(
> > 
> > I use a TechoTrend Premium card with that frontend on it. It worked 
> > fine until 2.6.10.
> > Can you put it back into mainline? Is there some work to do for 
> > reinsertion?
> 
> I think the driver you now need is sp8870. It's just another name for

Yup you are right. If someone has a card that is no longer working,
please have a look at these pages and contact the linuxtv-dvb mailing-list:

http://www.linuxtv.org/wiki/index.php/Supported_DVB_cards
http://www.linuxtv.org/wiki/index.php/DVB_cards_requiring_definition
http://www.linuxtv.org/lists.php

Kenneth
