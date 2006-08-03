Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932347AbWHCHGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932347AbWHCHGR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 03:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbWHCHGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 03:06:17 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18652 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932347AbWHCHGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 03:06:16 -0400
Date: Thu, 3 Aug 2006 00:05:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jay Lan <jlan@engr.sgi.com>
Cc: linux-kernel@vger.kernel.org, nagar@watson.ibm.com, balbir@in.ibm.com,
       jes@sgi.com, csturtiv@sgi.com, tee@sgi.com,
       guillaume.thouvenin@bull.net
Subject: Re: [patch 0/3] System accounting and taskstats update
Message-Id: <20060803000559.938017b2.akpm@osdl.org>
In-Reply-To: <44D17957.10209@engr.sgi.com>
References: <44D17957.10209@engr.sgi.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2006 21:19:35 -0700
Jay Lan <jlan@engr.sgi.com> wrote:

> This posting is to replace the "CSA accounting and taskstats
> update" patches i posted on 7/31.

Could I hassle you for a full API description?  I guess the actual
transport and data represenatation is covered by Shailabh's documents, but
it'd be valuable if you could prepare a Documentation file which describes
what the various fields mean and which explains when and how they are
accumulated and when they are delivered to userspace, etc.

Thanks.
