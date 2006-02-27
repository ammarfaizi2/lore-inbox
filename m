Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751499AbWB0RFX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbWB0RFX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 12:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWB0RFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 12:05:23 -0500
Received: from mx.pathscale.com ([64.160.42.68]:52176 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751499AbWB0RFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 12:05:22 -0500
Subject: Re: [Lse-tech] [Patch 2/7] Add sysctl for schedstats
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: nagar@watson.ibm.com
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <1141027923.5785.50.camel@elinux04.optonline.net>
References: <1141026996.5785.38.camel@elinux04.optonline.net>
	 <1141027367.5785.42.camel@elinux04.optonline.net>
	 <1141027923.5785.50.camel@elinux04.optonline.net>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 09:05:17 -0800
Message-Id: <1141059917.23775.41.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 03:12 -0500, Shailabh Nagar wrote:

> Add sysctl option for controlling schedstats collection
> dynamically. Delay accounting leverages schedstats for
> cpu delay statistics.

Is there some reason you're using the sysctl interface, and not say
sysfs instead?

	<b

