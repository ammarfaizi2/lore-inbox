Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964774AbVHYDJR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964774AbVHYDJR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 23:09:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbVHYDJR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 23:09:17 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:42911 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S964774AbVHYDJQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 23:09:16 -0400
X-ORBL: [67.124.117.85]
Date: Wed, 24 Aug 2005 20:09:09 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Doug Warzecha <Douglas_Warzecha@dell.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.13-rc6] dcdbas: add Dell Systems Management Base Driver with sysfs support
Message-ID: <20050825030909.GB6079@taniwha.stupidest.org>
References: <20050825020021.GA5223@sysman-doug.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050825020021.GA5223@sysman-doug.us.dell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2005 at 09:00:21PM -0500, Doug Warzecha wrote:

[...]

> +Dell OpenManage requires this driver on the following Dell PowerEdge systems:
> +300, 1300, 1400, 400SC, 500SC, 1500SC, 1550, 600SC, 1600SC, 650, 1655MC,
> +700, and 750.  Other Dell software such as the open source Libsmbios library
> +is expected to make use of this driver, and it may include the use of this
> +driver on other Dell systems.

I'd like to see a URL/pointer somewhere about here in the docs for the
location of libsmbios if nobody objects.
