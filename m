Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266167AbUBCWhN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 17:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266172AbUBCWhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 17:37:13 -0500
Received: from kalmia.drgw.net ([209.234.73.41]:17625 "EHLO kalmia.hozed.org")
	by vger.kernel.org with ESMTP id S266167AbUBCWhH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 17:37:07 -0500
Date: Tue, 3 Feb 2004 16:37:06 -0600
From: Troy Benjegerdes <hozer@hozed.org>
To: "Woodruff, Robert J" <woody@co.intel.com>
Cc: infiniband-general@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Message-ID: <20040203223706.GB11222@kalmia.hozed.org>
References: <F595A0622682C44DBBE0BBA91E56A5ED1C3662@orsmsx410.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <F595A0622682C44DBBE0BBA91E56A5ED1C3662@orsmsx410.jf.intel.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So, for starters, can you or Jerrie post a patch containing just the 2.6
infiniband access layer, Or create a new BK tree for 2.6 infiniband stuff
that uses the new 2.6 kbuild system?




On Mon, Feb 02, 2004 at 03:58:56PM -0800, Woodruff, Robert J wrote:
> 
> We were waiting until we had some version of the InfiniBand code ported
> to 2.6 before
> asking for it to be included in the 2.6 kernel tree. Jerrie made the
> changes
> to the IB access layer to allow it to compile on 2.6, but it cannot yet
> be tested 
> till we get a 2.6 driver from Mellanox. 
> 
> I'd also like to hear from the linux-kernel folks on what we would need
> to
> do to get a basic InfiniBand access layer included in the 2.6 base. 
> 
> We'd also like to hear from Mellanox if they have any plans to provide
> an open
> source VPD driver anytime soon. 
> 
> woody
> 
