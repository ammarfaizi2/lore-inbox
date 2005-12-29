Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVL2OVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVL2OVt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 09:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750732AbVL2OVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 09:21:49 -0500
Received: from mx.pathscale.com ([64.160.42.68]:24000 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1750728AbVL2OVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 09:21:49 -0500
Subject: Re: [openib-general] [PATCH 11 of 20] ipath - core driver, part 4
	of 4
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <ada1wzwbq62.fsf@cisco.com>
References: <e8af3873b0d910e0c623.1135816290@eng-12.pathscale.com>
	 <ada1wzwbq62.fsf@cisco.com>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 06:21:38 -0800
Message-Id: <1135866098.7790.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-28 at 18:19 -0800, Roland Dreier wrote:
> This seems very wrong to me: there's no guarantee that a module will
> be loaded into memory that can be used as a DMA target.

Right.  I think we're just getting lucky on x86_64.  I'll fix this.

Thanks,

	<b

-- 
Bryan O'Sullivan <bos@pathscale.com>

