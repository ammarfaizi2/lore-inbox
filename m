Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262522AbUBXXMG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 18:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbUBXXMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 18:12:06 -0500
Received: from main.gmane.org ([80.91.224.249]:51409 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262522AbUBXXME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 18:12:04 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jason Lunz <lunz@falooley.org>
Subject: Re: 2.6.3 oops at kobject_unregister, alsa & aic7xxx
Date: Tue, 24 Feb 2004 23:12:00 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <slrnc3nmi0.45i.lunz@absolut.localnet>
References: <1077546633.362.28.camel@boxen> <20040223160716.799195d0.akpm@osdl.org> <1077602725.3172.19.camel@opiate> <2098950000.1077645372@aslan.btc.adaptec.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: finn.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gibbs@scsiguy.com said:
>> I stumbled up this in early January.  I posted a patch to linux-scsi,
>> but it dosn't seem to be merged at this point.  This problem will also
>> occur with the aic79xx driver.
>
> After your report, I integrated a similar fix into the drivers posted
> from my site back in January.

great. Are you the new donald becker?

Jason

