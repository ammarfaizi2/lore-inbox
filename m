Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWFSPrl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWFSPrl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 11:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932497AbWFSPrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 11:47:41 -0400
Received: from mx.pathscale.com ([64.160.42.68]:23488 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932302AbWFSPrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 11:47:40 -0400
Date: Mon, 19 Jun 2006 08:47:29 -0700
From: Greg Lindahl <greg.lindahl@qlogic.com>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, Brice Goglin <brice@myri.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [discuss] Re: [RFC] Whitelist chipsets supporting MSI and check Hyper-transport capabilities
Message-ID: <20060619154728.GA15089@greglaptop.hsd1.ca.comcast.net>
Mail-Followup-To: Andi Kleen <ak@suse.de>, discuss@x86-64.org,
	Brice Goglin <brice@myri.com>, linux-kernel@vger.kernel.org
References: <4493709A.7050603@myri.com> <44941632.4050703@myri.com> <20060619005329.GA1425@greglaptop> <200606191028.51242.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606191028.51242.ak@suse.de>
User-Agent: Mutt/1.4.1i
X-Frumious: Bandersnatch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 10:28:50AM +0200, Andi Kleen wrote:

> Isn't your HCA directly connected to HTX? If yes it will
> likely not run into PCI bridge bugs.

I was referring to our new PCI Express HCA.

-- greg

