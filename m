Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262728AbTESWQZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTESWQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:16:25 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:52620 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262728AbTESWQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:16:22 -0400
Date: Tue, 20 May 2003 00:29:10 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Jeffrey W. Baker" <jwbaker@acm.org>,
       "Mudama, Eric" <eric_mudama@maxtor.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HD DMA disabled in 2.4.21-rc2, works fine in 2.4.20
Message-ID: <20030519222910.GG4757@louise.pinerecords.com>
References: <785F348679A4D5119A0C009027DE33C102E0D3AB@mcoexc04.mlm.maxtor.com> <1053374646.10240.5.camel@heat> <1053373513.29226.25.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053373513.29226.25.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [alan@lxorguk.ukuu.org.uk]
> 
> On Llu, 2003-05-19 at 21:04, Jeffrey W. Baker wrote:
> > I was using Via IDE chipset and, yes, I had configured the kernel for
> > VIA support.  That's why it worked in 2.4.20.  But it stopped working in
> > 2.4.21-rc.
> 
> VIA IDE should be working reliably, my main test box is an EPIA series
> VIA system so the VIA IDE does get a fair beating

This person is running with CONFIG_BLK_DEV_VIA82CXXX unset.

-- 
Tomas Szepe <szepe@pinerecords.com>
