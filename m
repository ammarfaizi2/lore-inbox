Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWCWIqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWCWIqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 03:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965308AbWCWIqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 03:46:10 -0500
Received: from mx.pathscale.com ([64.160.42.68]:59788 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964895AbWCWIqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 03:46:09 -0500
Subject: Re: [PATCH 8 of 18] ipath - sysfs and ipathfs support for core
	driver
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: linux-kernel@vger.kernel.org, rdreier@cisco.com, greg@kroah.com,
       openib-general@openib.org
In-Reply-To: <20060323063049.GB9841@mellanox.co.il>
References: <patchbomb.1143072293@eng-12.pathscale.com>
	 <03375633b9c13068de17.1143072301@eng-12.pathscale.com>
	 <20060323063049.GB9841@mellanox.co.il>
Content-Type: text/plain
Date: Thu, 23 Mar 2006 00:46:08 -0800
Message-Id: <1143103569.6411.18.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-23 at 08:30 +0200, Michael S. Tsirkin wrote:

> InfiniBand core already exposes these attributes to userspace, see
> drivers/infiniband/core/sysfs.c

This is needed for cases where the Infiniband stack isn't present.

	<b

