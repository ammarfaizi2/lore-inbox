Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVC2Xr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVC2Xr4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 18:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVC2Xrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 18:47:55 -0500
Received: from relay.axxeo.de ([213.239.199.237]:7362 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S261669AbVC2XqN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 18:46:13 -0500
From: Ingo Oeser <ioe-lkml@axxeo.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: Re: [ARM] Group device drivers together under their own menu
Date: Wed, 30 Mar 2005 01:46:03 +0200
User-Agent: KMail/1.7.1
Cc: Matthew Wilcox <matthew@wil.cx>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200503261912.j2QJC192031517@hera.kernel.org> <20050327004549.GS21986@parcelfarce.linux.theplanet.co.uk> <424607EA.50808@osdl.org>
In-Reply-To: <424607EA.50808@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503300146.03688.ioe-lkml@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Randy.Dunlap wrote:
> The real problem AFAICT is that Networking options
> includes some protocols and then Network Device Support
> includes some other protocols.  Maybe if there was a Network Protocol
> section things could be clearer.  ??

I would really welcome that change. 

Regards

Ingo Oeser

