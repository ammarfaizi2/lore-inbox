Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266018AbTGSMBy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 08:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266169AbTGSMBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 08:01:54 -0400
Received: from dclient217-162-108-200.hispeed.ch ([217.162.108.200]:32773 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S266018AbTGSMBx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 08:01:53 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: Tom Sightler <ttsig@tuxyturvy.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG REPORT 2.6.0] cisco airo_cs scheduling while atomic
Date: Sat, 19 Jul 2003 14:17:14 +0200
User-Agent: KMail/1.5.2
Cc: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307191417.14321.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well Daniel Ritz has posted a big fix to the driver so I threw mine away. 
> > I'll include it in the next -mm, so please test that.
>
> I've applied Daniel's patch to my 2.6.0-test1-mm1 tree on two of my test
> systems (a PCMCIA and PCI version of the Aironet 350 series) and both
> are working great.  His patches look pretty obviously correct to me and
> are much cleaner than the hacked up patches I've been sending out to
> people to get the card working on recent 2.5.7x kernels.  Just wanted to
> report the success.
>

thanx...nice to hear that it works...

> Later,
> Tom
>

-daniel

