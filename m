Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbTD2Ued (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 16:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbTD2Uec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 16:34:32 -0400
Received: from [195.208.223.247] ([195.208.223.247]:11136 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261753AbTD2Ueb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 16:34:31 -0400
Date: Wed, 30 Apr 2003 00:46:33 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] DMA mapping API for Alpha
Message-ID: <20030430004633.A1473@localhost.park.msu.ru>
References: <1051647735.2501.45.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1051647735.2501.45.camel@mulgrave>; from James.Bottomley@SteelEye.com on Tue, Apr 29, 2003 at 03:22:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 03:22:12PM -0500, James Bottomley wrote:
>  I use the platform_data field to cache the
> particular IO-MMU the device is connected to.  I assume this is the same
> in alpha?

Exactly.

Ivan.
