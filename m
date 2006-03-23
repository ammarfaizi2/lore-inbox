Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030217AbWCWIsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030217AbWCWIsX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 03:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030224AbWCWIsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 03:48:23 -0500
Received: from mx.pathscale.com ([64.160.42.68]:6541 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1030217AbWCWIsW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 03:48:22 -0500
Subject: Re: [PATCH 9 of 18] ipath - char devices for diagnostics and
	lightweight subnet management
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-kernel@vger.kernel.org, rdreier@cisco.com, greg@kroah.com,
       openib-general@openib.org
In-Reply-To: <20060323064113.GC9841@mellanox.co.il>
References: <patchbomb.1143072293@eng-12.pathscale.com>
	 <dffa0687112e4fdcf7d0.1143072302@eng-12.pathscale.com>
	 <20060323064113.GC9841@mellanox.co.il>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 00:48:21 -0800
Message-Id: <1143103701.6411.21.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 08:41 +0200, Michael S. Tsirkin wrote:

> Could you please explain why is this useful? Users could not care less - they
> never have to touch an SMA.

We have customers who use our driver who do not want a full IB stack
present, for example in embedded environments.

	<b

