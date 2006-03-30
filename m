Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWC3Vzw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWC3Vzw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 16:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbWC3Vzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 16:55:52 -0500
Received: from mx.pathscale.com ([64.160.42.68]:22210 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751012AbWC3Vzv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 16:55:51 -0500
Subject: Re: [PATCH 16 of 16] ipath - kbuild infrastructure
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <adaek0j1w25.fsf@cisco.com>
References: <36bfb4f1ad322a8fb23e.1143674619@chalcedony.internal.keyresearch.com>
	 <adaek0j1w25.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 30 Mar 2006 13:55:51 -0800
Message-Id: <1143755751.24402.11.camel@chalcedony.internal.keyresearch.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 (2.6.0-1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-30 at 13:06 -0800, Roland Dreier wrote:

> I'm not sure what the cleanest way to fix this.

I did ask at one point whether the core driver should live in a
directory in drivers/char/, since it's not really an IB driver at all,
and just have the IB-specific stuff live in drivers/infiniband/hw/.

I'm still amenable to doing that.

> Sorry for not noticing this sooner...

No worries.

	<b

