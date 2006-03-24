Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWCXU6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWCXU6h (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 15:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWCXU6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 15:58:37 -0500
Received: from mtaout4.012.net.il ([84.95.2.10]:46057 "EHLO mtaout4.012.net.il")
	by vger.kernel.org with ESMTP id S1750792AbWCXU6g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 15:58:36 -0500
Date: Fri, 24 Mar 2006 22:57:57 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH 0 of 18] ipath driver - for inclusion in 2.6.17
In-reply-to: <1143227515.30626.43.camel@serpentine.pathscale.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Roland Dreier <rdreier@cisco.com>, akpm@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Message-id: <20060324205757.GG2598@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <patchbomb.1143175292@eng-12.pathscale.com>
 <ada4q1nr7pu.fsf@cisco.com>
 <1143227515.30626.43.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2006 at 11:11:55AM -0800, Bryan O'Sullivan wrote:

> That's going to be interesting to test, because I don't have any ia64
> hardware to even compile on.  I have tested on x86_64 and powerpc, so
> this seems like an arch-level header deficiency.  Any idea what to do
> about it?

You can build an ia64 (or almost any other arch) toolchain using
crosstool and compile test with
it. http://www.kegel.com/crosstool/#download

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/

