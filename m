Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTESWrs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 18:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263276AbTESWrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 18:47:48 -0400
Received: from [65.198.37.67] ([65.198.37.67]:57266 "EHLO gghcwest.com")
	by vger.kernel.org with ESMTP id S263275AbTESWrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 18:47:40 -0400
Subject: Re: HD DMA disabled in 2.4.21-rc2, works fine in 2.4.20
From: "Jeffrey W. Baker" <jwbaker@acm.org>
To: Tomas Szepe <szepe@pinerecords.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030519222910.GG4757@louise.pinerecords.com>
References: <785F348679A4D5119A0C009027DE33C102E0D3AB@mcoexc04.mlm.maxtor.com>
	 <1053374646.10240.5.camel@heat>
	 <1053373513.29226.25.camel@dhcp22.swansea.linux.org.uk>
	 <20030519222910.GG4757@louise.pinerecords.com>
Content-Type: text/plain
Message-Id: <1053385232.10292.13.camel@heat>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 19 May 2003 16:00:33 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-19 at 15:29, Tomas Szepe wrote:
> > [alan@lxorguk.ukuu.org.uk]
> > 
> > On Llu, 2003-05-19 at 21:04, Jeffrey W. Baker wrote:
> > > I was using Via IDE chipset and, yes, I had configured the kernel for
> > > VIA support.  That's why it worked in 2.4.20.  But it stopped working in
> > > 2.4.21-rc.
> > 
> > VIA IDE should be working reliably, my main test box is an EPIA series
> > VIA system so the VIA IDE does get a fair beating
> 
> This person is running with CONFIG_BLK_DEV_VIA82CXXX unset.

No, this person is not.  

-jwb

