Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965210AbVHJRFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965210AbVHJRFS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 13:05:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965212AbVHJRFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 13:05:18 -0400
Received: from hera.kernel.org ([209.128.68.125]:56243 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S965210AbVHJRFQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 13:05:16 -0400
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: Skbuff problem - kernel BUG ???
Date: Wed, 10 Aug 2005 10:05:52 -0700
Organization: OSDL
Message-ID: <20050810100552.0f9ed87c@dxpl.pdx.osdl.net>
References: <AE99B7B733E1BB49B019CAA0F806D7A7014BF9C8@nets13ka.ww300.siemens.net>
	<1123683888.5340.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1123693511 6341 10.8.0.74 (10 Aug 2005 17:05:11 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 10 Aug 2005 17:05:11 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 1.9.11 (GTK+ 2.6.7; x86_64-redhat-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

O
> > Technical Data:
> > ---------------
> > System: Linux sb1-1 2.4.20_mvlcge31-mpcbl0001_V2.0.8-omm #1 SMP Mi
> > Aug 3 15:15:31 CEST 2005 i686 unknown
> > Vendor/Version: MontaVista-Linux Carrier-Grade-Edition 3.1
> > gcc: 3.2.3
> > CPU: 2 x Xeon 1.6(HT)
> > Networkdriver: e1000 (compiled into kernel)
> 
> OK, you did mention the kernel, but this is a MontaVista kernel and I
> have no idea what they did to it.
> 

And since we can't download a MontaVista kernel source to help,
you better use the MontaVista support to help you
