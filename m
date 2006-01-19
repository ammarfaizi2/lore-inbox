Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161037AbWASGsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161037AbWASGsh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 01:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161038AbWASGsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 01:48:36 -0500
Received: from pat.uio.no ([129.240.130.16]:27543 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1161037AbWASGsg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 01:48:36 -0500
Subject: Re: - add-pselect-ppoll-system-call-implementation-tidy.patch
	removed from -mm tree
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: "David S. Miller" <davem@davemloft.net>
Cc: sfr@canb.auug.org.au, dwmw2@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060118.223629.100108404.davem@davemloft.net>
References: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net>
	 <1137648119.30084.94.camel@localhost.localdomain>
	 <20060119171708.7f856b42.sfr@canb.auug.org.au>
	 <20060118.223629.100108404.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 19 Jan 2006 01:47:59 -0500
Message-Id: <1137653279.27267.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.708, required 12,
	autolearn=disabled, AWL 1.10, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 22:36 -0800, David S. Miller wrote:
> I wish there were an exception for function prototypes and definitions.
> Why?  So grep actually works.

Seconded! Even people with antediluvian editors will find it useful to
be able to grep for function prototypes and/or definitions in order to
figure out argument definitions, argument orders, etc.

Cheers,
  Trond

